module Ui.Component.Common.Timeline.HandleAction.HandleHandleDocScrollEnd
  ( handleHandleDocScrollEnd
  ) where

import Proem

import Ui.Component.Common.Timeline.HandleAction.HandleSelectItemByDate (handleSelectItemByDate)
import Ui.Component.Common.Timeline.HandleAction.Util (getAllDateElements, isDateVisible)
import Ui.Component.Common.Timeline.Type (TimelineM)
import Ui.Component.Common.Timeline.Util (parseDateDataAttr)
import Data.Foldable (for_, minimumBy)
import Data.Maybe (Maybe(..))
import Data.Number (abs)
import Data.Traversable (traverse)
import Effect.Ref (write)
import Halogen (get)
import Util.Html.Dom (dataAttrPrefixed, getHalfScreenHeight)
import Util.Proxy.Dictionary.Date (date')
import Web.DOM.Element (Element, getAttribute, getBoundingClientRect)

handleHandleDocScrollEnd :: ∀ w i. TimelineM w i Unit
handleHandleDocScrollEnd = do
  state <- get 
  
  for_ state.scrollFork \ref ->
    ʌ $ write Nothing ref

  selectDateClosestToScreenCenterIfNeeded

selectDateClosestToScreenCenter :: ∀ w i. TimelineM w i Unit
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

selectDateClosestToScreenCenterIfNeeded :: ∀ w i. TimelineM w i Unit
selectDateClosestToScreenCenterIfNeeded = do
  state <- get

  state.selectedItem
    ??
      ( \selectedItem -> do
          isVisible <- isDateVisible selectedItem.date
          unless isVisible selectDateClosestToScreenCenter
      )
    ⇔ selectDateClosestToScreenCenter

calculateDistancesFromCenter
  :: forall w i 
   . Array Element
  -> Number
  -> TimelineM w i (Array { distance :: Number, dataDate :: Maybe String })
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
  :: ∀ w i
   . Array { distance :: Number, dataDate :: Maybe String }
  -> TimelineM w i Unit
selectClosestDate distancesWithDates =
  minimumBy (\a b -> compare a.distance b.distance) distancesWithDates
    ??
      ( \closest ->
          for_ closest.dataDate \dateStr ->
            for_ (parseDateDataAttr dateStr) \date ->
              handleSelectItemByDate date
      )
    ⇔ ηι
