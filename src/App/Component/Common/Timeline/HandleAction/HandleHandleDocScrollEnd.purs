module App.Component.Common.Timeline.HandleAction.HandleHandleDocScrollEnd
  ( handleHandleDocScrollEnd
  ) where

import Proem

import App.Component.Common.Timeline.HandleAction.HandleSelectDate (handleSelectDate)
import App.Component.Common.Timeline.HandleAction.Util (getAllDateElements, isDateVisible)
import App.Component.Common.Timeline.Type (TimelineM)
import App.Component.Common.Timeline.Util (parseDateDataAttr)
import Data.Foldable (for_, minimumBy)
import Data.Maybe (Maybe(..))
import Data.Number (abs)
import Data.Traversable (traverse)
import Effect.Ref (write)
import Halogen (get)
import Util.Html.Dom (dataAttrPrefixed, getHalfScreenHeight)
import Util.Proxy.Dictionary.Date (date')
import Web.DOM.Element (Element, getAttribute, getBoundingClientRect)

handleHandleDocScrollEnd :: TimelineM Unit
handleHandleDocScrollEnd = do
  state <- get 
  
  for_ state.scrollFork \ref ->
    ʌ $ write Nothing ref

  selectDateClosestToScreenCenterIfNeeded

selectDateClosestToScreenCenter :: TimelineM Unit
selectDateClosestToScreenCenter = do
  elements <- getAllDateElements

  elements
    ??
      ( \el -> do
          halfScreenHeight <- getHalfScreenHeight
          distancesWithDates <- calculateDistancesFromCenter el halfScreenHeight
          selectClosestDate distancesWithDates
      )
    ⇔ ηι

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
        maybeDataDate <- getAttribute (dataAttrPrefixed date') el
        η { distance, dataDate: maybeDataDate }
    )
    elements

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
