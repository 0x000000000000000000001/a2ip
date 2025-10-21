module Component.Common.Timeline.HandleAction
  ( handleAction
  )
  where

import Proem

import Capability.AppM (AppM)
import Capability.Log (debug)
import Component.Common.Timeline.Type (Action(..), Date(..), Output(..), Slots, State)
import Data.Array (nubEq, mapMaybe, (!!))
import Data.Foldable (for_, minimumBy)
import Data.Int (fromString, toNumber)
import Data.Maybe (Maybe(..))
import Data.Newtype (unwrap)
import Data.Number (abs)
import Data.String (Pattern(..), split)
import Data.Time.Duration (Milliseconds(..))
import Data.Traversable (traverse)
import Effect.Aff (delay)
import Effect.Aff.Class (liftAff)
import Effect.Class (liftEffect)
import Halogen (HalogenM, fork, get, kill, modify_, raise, subscribe)
import Halogen.Query.Event (eventListener)
import Web.DOM.Document (toEventTarget)
import Web.DOM.Element (fromNode, getAttribute, getBoundingClientRect)
import Web.DOM.NodeList (toArray)
import Web.DOM.ParentNode (QuerySelector(..), querySelectorAll)
import Web.Event.Event (EventType(..))
import Web.HTML (window)
import Web.HTML.HTMLDocument (toDocument, toParentNode)
import Web.HTML.Window (document, innerHeight)

handleAction :: Action -> HalogenM State Action Slots Output AppM Unit
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
    debug "Scroll"
    state <- get
    for_ state.scrollFork kill
    
    forkId <- fork do
      liftAff $ delay $ Milliseconds 150.0
      handleAction HandleScrollEnd
      
    modify_ _ { scrollFork = Just forkId }
    
  HandleScrollEnd -> do
    debug "Scroll ended"
    modify_ _ { scrollFork = Nothing }
    selectDateClosestToScreenCenterIfNeeded
    ηι

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
selectDateClosestToScreenCenter :: HalogenM State Action Slots Output AppM Unit
selectDateClosestToScreenCenter = do
  maybeElements <- getDateElements
  case maybeElements of
    Nothing -> pure ι
    Just elements -> do
      screenCenter <- getScreenCenter
      distancesWithDates <- calculateDistancesFromCenter elements screenCenter
      selectClosestDate distancesWithDates

-- | Check if a date element is visible on screen
isDateVisible :: Date -> HalogenM State Action Slots Output AppM Boolean
isDateVisible date = liftEffect do
  let d = unwrap date
      dateId = show d.day <> "-" <> show d.month <> "-" <> show d.year
  win <- window
  doc <- document win
  screenHeight <- toNumber <$> innerHeight win
  
  nodeList <- querySelectorAll (QuerySelector $ "[data-date=\"" <> dateId <> "\"]") (toParentNode doc)
  nodes <- toArray nodeList
  let elements = nodes # mapMaybe fromNode
  
  case elements of
    [] -> pure false
    [element] -> do
      rect <- getBoundingClientRect element
      pure $ rect.top >= 0.0 && rect.bottom <= screenHeight
    _ -> pure false

-- | Select the closest date only if the currently selected date is not visible
selectDateClosestToScreenCenterIfNeeded :: HalogenM State Action Slots Output AppM Unit
selectDateClosestToScreenCenterIfNeeded = do
  state <- get
  case state.selectedDate of
    Nothing -> selectDateClosestToScreenCenter
    Just selectedDate -> do
      isVisible <- isDateVisible selectedDate
      unless isVisible selectDateClosestToScreenCenter

-- | Get all date elements from the DOM
getDateElements :: HalogenM State Action Slots Output AppM (Maybe (Array _))
getDateElements = liftEffect do
  win <- window
  doc <- document win
  nodeList <- querySelectorAll (QuerySelector "[data-date]") (toParentNode doc)
  nodes <- toArray nodeList
  let elements = nodes # mapMaybe fromNode
  case elements of
    [] -> pure Nothing
    _ -> pure $ Just elements

-- | Get the vertical center of the screen
getScreenCenter :: HalogenM State Action Slots Output AppM Number
getScreenCenter = liftEffect do
  win <- window
  screenHeight <- innerHeight win
  pure $ toNumber screenHeight / 2.0

-- | Calculate the distance from screen center for each element
calculateDistancesFromCenter 
  :: Array _
  -> Number
  -> HalogenM State Action Slots Output AppM (Array { distance :: Number, dataDate :: Maybe String })
calculateDistancesFromCenter elements screenCenter = 
  liftEffect $ traverse (\el -> do
    rect <- getBoundingClientRect el
    let elementCenter = rect.top + (rect.height / 2.0)
        distance = abs (elementCenter - screenCenter)
    maybeDataDate <- getAttribute "data-date" el
    pure { distance, dataDate: maybeDataDate }
  ) elements

-- | Select the date closest to the center
selectClosestDate 
  :: Array { distance :: Number, dataDate :: Maybe String }
  -> HalogenM State Action Slots Output AppM Unit
selectClosestDate distancesWithDates = 
  case minimumBy (\a b -> compare a.distance b.distance) distancesWithDates of
    Nothing -> pure ι
    Just closest -> 
      for_ closest.dataDate \dateStr -> 
        for_ (parseDate dateStr) \date -> 
          handleAction $ SelectDate date