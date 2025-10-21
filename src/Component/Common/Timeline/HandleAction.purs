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
    
    -- Find the date element closest to the center of the screen
    win <- liftEffect window
    doc <- liftEffect $ document win
    screenHeight <- liftEffect $ innerHeight win
    let screenCenter = toNumber screenHeight / 2.0
    
    nodeList <- liftEffect $ querySelectorAll (QuerySelector "[data-date]") (toParentNode doc)
    nodes <- liftEffect $ toArray nodeList
    let elements = nodes # mapMaybe fromNode
    
    -- Calculate distance from center for each element
    distancesWithDates <- liftEffect $ traverse (\el -> do
      rect <- getBoundingClientRect el
      let elementCenter = rect.top + (rect.height / 2.0)
          distance = abs (elementCenter - screenCenter)
      maybeDataDate <- getAttribute "data-date" el
      pure { distance, dataDate: maybeDataDate, element: el }
    ) elements
    
    -- Find the element closest to center
    case minimumBy (\a b -> compare a.distance b.distance) distancesWithDates of
      Nothing -> pure ι
      Just closest -> 
        case closest.dataDate of
          Nothing -> pure ι
          Just dateStr -> do
            -- Parse date string (format: "day-month-year")
            case parseDate dateStr of
              Nothing -> pure ι
              Just date -> handleAction $ SelectDate date
    
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