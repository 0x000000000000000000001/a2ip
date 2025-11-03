module App.Component.Common.Timeline.Type
  ( Action(..)
  , DefaultDate(..)
  , Input
  , Output(..)
  , Query
  , Slots
  , State
  , TimelineM
  )
  where


import App.Component.Util.Type (NoQuery, NoSlots)
import App.Util.Capability.AppM (AppM)
import Data.Date (Date)
import Data.Maybe (Maybe)
import Effect.Ref (Ref)
import Halogen (HalogenM)
import Halogen.Query (ForkId)

data DefaultDate = First | Last | LastBeforeNow | FirstAfterNow | None

type Input =
  { class_ :: Maybe String
  , dates :: Array Date
  , loading :: Boolean
  , defaultDate :: DefaultDate
  }

data Output = SelectedDate (Maybe Date)

type Slots :: ∀ k. Row k
type Slots = NoSlots

type State = 
  { input :: Input
  , selectedDate :: Maybe Date
  , scrollFork :: Maybe (Ref (Maybe ForkId))
  }

data Action 
  = Initialize
  | SelectDate Date 
  | Receive Input
  | HandleDocScroll
  | HandleDocScrollEnd

type Query :: ∀ k. k -> Type
type Query = NoQuery

type TimelineM a = HalogenM State Action Slots Output AppM a

