module App.Component.Common.Timeline.HandleAction
  ( handleAction
  ) where

import Proem

import App.Component.Common.Timeline.Type (Action(..), DefaultDate(..), Output(..), TimelineM, date)
import App.Util.Capability.Log (debug)
import Data.Array (filter, last, length, mapMaybe, nubEq, (!!))
import Data.Date (Date, canonicalDate, day, month, year)
import Data.Enum (fromEnum, toEnum)
import Data.Foldable (for_, minimumBy)
import Data.Int (fromString)
import Data.Maybe (Maybe(..), fromJust)
import Data.Number (abs)
import Data.String (Pattern(..), split)
import Data.Time.Duration (Milliseconds(..))
import Data.Traversable (traverse)
import Effect.Aff (delay)
import Effect.Now (nowDate)
import Halogen (fork, get, kill, modify, modify_, raise, subscribe')
import Halogen.Query.Event (eventListener)
import Partial.Unsafe (unsafePartial)
import Util.Html.Dom (dataAttrPrefixed, dataAttrQuerySelector, isVisible, scroll)
import Util.Window (getScreenVerticalCenter)
import Web.DOM.Document (toEventTarget)
import Web.DOM.Element (Element, fromNode, getAttribute, getBoundingClientRect)
import Web.DOM.NodeList (toArray)
import Web.DOM.ParentNode (querySelectorAll)
import Web.HTML (window)
import Web.HTML.HTMLDocument (toDocument, toParentNode)
import Web.HTML.Window (document)

handleAction :: Action -> TimelineM Unit
handleAction = case _ of
  Initialize -> do
    doc <- ʌ $ document =<< window
    subscribe' $ κ $ eventListener
      scroll
      (doc # toDocument # toEventTarget)
      (HandleDocScroll # Just # κ)

  SelectDate date -> do
    modify_ _ { selectedDate = Just date }
    raise $ SelectedDate $ Just date

  Receive input -> do
    now <- ʌ nowDate

    let dates = input.dates # nubEq
        defaultDate = case input.defaultDate of
          First -> dates !! 0
          Last -> dates !! (length dates - 1)
          LastBeforeNow -> dates # filter (_ < now) # last
          FirstAfterNow -> (dates # filter (_ > now)) !! 0
          _ -> Nothing

    debug $ "defaultDate: " <> show defaultDate

    oldState <- get
    let oldSelectedDate = oldState.selectedDate

    newState <- modify (\s -> s 
      { class_ = input.class_
      , dates = dates
      , selectedDate = s.dates /= dates ? defaultDate ↔ s.selectedDate 
      , loading = input.loading
      }
    )

    let newSelectedDate = newState.selectedDate
    when 
      (oldSelectedDate /= newSelectedDate) 
      (raise $ SelectedDate newSelectedDate)

  HandleDocScroll -> do
    state <- get
    for_ state.scrollFork kill

    forkId <- fork do
      ʌ' $ delay $ Milliseconds 150.0
      handleAction HandleDocScrollEnd

    modify_ _ { scrollFork = Just forkId }

  HandleDocScrollEnd -> do
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
  η $ 
    unsafePartial $
      canonicalDate
        (year # toEnum # fromJust)
        (month # toEnum # fromJust)
        (day # toEnum # fromJust)

-- | Select the date element that is closest to the center of the screen
selectDateClosestToScreenCenter :: TimelineM Unit
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

isDateVisible :: Date -> TimelineM Boolean
isDateVisible date_ = do
  let
    d = fromEnum $ day date_
    m = fromEnum $ month date_
    y = fromEnum $ year date_
    dateId = show d <> "-" <> show m <> "-" <> show y
  isVisible (dataAttrQuerySelector date (Just dateId))

-- | Get all date elements from the DOM
getDateElements :: TimelineM (Maybe (Array Element))
getDateElements = ʌ do
  win <- window
  doc <- document win
  nodeList <- querySelectorAll (dataAttrQuerySelector date Nothing) (toParentNode doc)
  nodes <- toArray nodeList
  let elements = nodes # mapMaybe fromNode
  case elements of
    [] -> η Nothing
    _ -> η $ Just elements

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
          elementVerticalCenter = rect.top + (rect.height / 2.0)
          distance = abs (elementVerticalCenter - screenCenter)
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
            for_ (parseDate dateStr) \date ->
              handleAction $ SelectDate date
      )
    ⇔ ηι