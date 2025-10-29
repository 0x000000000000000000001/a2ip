module App.Component.Common.Timeline.HandleAction.HandleHandleDocScrollEnd
  ( handleHandleDocScrollEnd
  ) where

import Proem

import App.Component.Common.Timeline.HandleAction.HandleSelectDate (handleSelectDate)
import App.Component.Common.Timeline.HandleAction.Util (getAllDateElements, isDateVisible)
import App.Component.Common.Timeline.Type (TimelineM, date)
import App.Component.Common.Timeline.Util (parseDateDataAttr)
import Data.Foldable (for_, minimumBy)
import Data.Maybe (Maybe(..))
import Data.Number (abs)
import Data.Traversable (traverse)
import Halogen (get, modify_)
import Util.Html.Dom (dataAttrPrefixed)
import Util.Window (getScreenVerticalCenter)
import Web.DOM.Element (Element, getAttribute, getBoundingClientRect)

handleHandleDocScrollEnd :: TimelineM Unit
handleHandleDocScrollEnd = do
  modify_ _ { scrollFork = Nothing }

  selectDateClosestToScreenCenterIfNeeded

-- | Select the date element that is closest to the center of the screen
selectDateClosestToScreenCenter :: TimelineM Unit
selectDateClosestToScreenCenter = do
  maybeElements <- getAllDateElements
  maybeElements
    ??
      ( \elements -> do
          screenVerticalCenter <- getScreenVerticalCenter
          distancesWithDates <- calculateDistancesFromCenter elements screenVerticalCenter
          selectClosestDate distancesWithDates
      )
    ⇔ ηι

-- | Select the closest date only if the currently selected date is not visible
selectDateClosestToScreenCenterIfNeeded :: TimelineM Unit
selectDateClosestToScreenCenterIfNeeded = do
  state <- get
  state.selectedDate
    ??
      ( \selectedDate -> do
          isVisible <- isDateVisible selectedDate
          unless isVisible selectDateClosestToScreenCenter
      )
    ⇔ selectDateClosestToScreenCenter

-- | Calculate the distance from screen center for each element
calculateDistancesFromCenter
  :: Array Element
  -> Number
  -> TimelineM (Array { distance :: Number, dataDate :: Maybe String })
calculateDistancesFromCenter elements screenCenter =
  ʌ $ traverse
    ( \el -> do
        rect <- getBoundingClientRect el
        let
          elementMiddle = rect.top + (rect.height / 2.0)
          distance = abs (elementMiddle - screenCenter)
        maybeDataDate <- getAttribute (dataAttrPrefixed date) el
        η { distance, dataDate: maybeDataDate }
    )
    elements

-- | Select the date closest to the center
selectClosestDate
  :: Array { distance :: Number, dataDate :: Maybe String }
  -> TimelineM Unit
selectClosestDate distancesWithDates =
  minimumBy (\a b -> compare a.distance b.distance) distancesWithDates
    ??
      ( \closest ->
          for_ closest.dataDate \dateStr ->
            for_ (parseDateDataAttr dateStr) \date ->
              handleSelectDate date
      )
    ⇔ ηι
