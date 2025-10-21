module Component.Common.Timeline.HandleAction
  ( handleAction
  ) where

import Proem

import Component.Common.Timeline.Type (Action(..), ComponentM, Date(..), Output(..), date)
import Data.Array (nubEq, mapMaybe, (!!))
import Data.Foldable (for_, minimumBy)
import Data.Int (fromString)
import Data.Maybe (Maybe(..))
import Data.Newtype (unwrap)
import Data.Number (abs)
import Data.String (Pattern(..), split)
import Data.Time.Duration (Milliseconds(..))
import Data.Traversable (traverse)
import Effect.Aff (delay)
import Effect.Aff.Class (liftAff)
import Effect.Class (liftEffect)
import Halogen (fork, get, kill, modify_, raise, subscribe)
import Halogen.Query.Event (eventListener)
import Util.Html.Dom (dataAttrPrefixed, dataAttrQuerySelector, isVisible)
import Util.Window (getScreenVerticalCenter)
import Web.DOM.Document (toEventTarget)
import Web.DOM.Element (Element, fromNode, getAttribute, getBoundingClientRect)
import Web.DOM.NodeList (toArray)
import Web.DOM.ParentNode (querySelectorAll)
import Web.Event.Event (EventType(..))
import Web.HTML (window)
import Web.HTML.HTMLDocument (toDocument, toParentNode)
import Web.HTML.Window (document)

handleAction :: Action -> ComponentM Unit
handleAction = case _ of
  Initialize -> do
    doc <- liftEffect $ document =<< window
    void $ subscribe $ eventListener
      (EventType "scroll")
      (toEventTarget $ toDocument doc)
      (κ $ Just HandleScroll)

  Finalize ->
    pure unit

  SelectDate date -> do
    modify_ _ { selectedDate = Just date }
    raise $ SelectedDate date

  Receive input ->
    modify_ _ { class_ = input.class_, dates = input.dates # nubEq }

  HandleScroll -> do
    state <- get
    for_ state.scrollFork kill

    forkId <- fork do
      liftAff $ delay $ Milliseconds 150.0
      handleAction HandleScrollEnd

    modify_ _ { scrollFork = Just forkId }

  HandleScrollEnd -> do
    modify_ _ { scrollFork = Nothing }

    selectDateClosestToScreenCenterIfNeeded

parseDate :: String -> Maybe Date
parseDate str = do
  let parts = split (Pattern "-") str
  dayStr <- parts !! 0
  monthStr <- parts !! 1
  yearStr <- parts !! 2
  day <- fromString dayStr
  month <- fromString monthStr
  year <- fromString yearStr
  pure $ Date { day, month, year }

-- | Select the date element that is closest to the center of the screen
selectDateClosestToScreenCenter :: ComponentM Unit
selectDateClosestToScreenCenter = do
  maybeElements <- getDateElements
  maybeElements
    ??
      ( \elements -> do
          screenVerticalCenter <- getScreenVerticalCenter
          distancesWithDates <- calculateDistancesFromCenter elements screenVerticalCenter
          selectClosestDate distancesWithDates
      )
    ⇔ ηι

-- | Select the closest date only if the currently selected date is not visible
selectDateClosestToScreenCenterIfNeeded :: ComponentM Unit
selectDateClosestToScreenCenterIfNeeded = do
  state <- get
  state.selectedDate
    ??
      ( \selectedDate -> do
          isVisible <- isDateVisible selectedDate
          unless isVisible selectDateClosestToScreenCenter
      )
    ⇔ selectDateClosestToScreenCenter

isDateVisible :: Date -> ComponentM Boolean
isDateVisible date_ = do
  let
    d = unwrap date_
    dateId = show d.day <> "-" <> show d.month <> "-" <> show d.year
  isVisible (dataAttrQuerySelector date (Just dateId))

-- | Get all date elements from the DOM
getDateElements :: ComponentM (Maybe (Array Element))
getDateElements = liftEffect do
  win <- window
  doc <- document win
  nodeList <- querySelectorAll (dataAttrQuerySelector date Nothing) (toParentNode doc)
  nodes <- toArray nodeList
  let elements = nodes # mapMaybe fromNode
  case elements of
    [] -> pure Nothing
    _ -> pure $ Just elements

-- | Calculate the distance from screen center for each element
calculateDistancesFromCenter
  :: Array Element
  -> Number
  -> ComponentM (Array { distance :: Number, dataDate :: Maybe String })
calculateDistancesFromCenter elements screenCenter =
  liftEffect $ traverse
    ( \el -> do
        rect <- getBoundingClientRect el
        let
          elementVerticalCenter = rect.top + (rect.height / 2.0)
          distance = abs (elementVerticalCenter - screenCenter)
        maybeDataDate <- getAttribute (dataAttrPrefixed date) el
        pure { distance, dataDate: maybeDataDate }
    )
    elements

-- | Select the date closest to the center
selectClosestDate
  :: Array { distance :: Number, dataDate :: Maybe String }
  -> ComponentM Unit
selectClosestDate distancesWithDates =
  minimumBy (\a b -> compare a.distance b.distance) distancesWithDates
    ??
      ( \closest ->
          for_ closest.dataDate \dateStr ->
            for_ (parseDate dateStr) \date ->
              handleAction $ SelectDate date
      )
    ⇔ ηι