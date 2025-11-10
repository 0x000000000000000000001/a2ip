module App.Component.Common.Timeline.Type
  ( Action(..)
  , DefaultDate(..)
  , Input
  , Item
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
import Halogen.HTML.Core (HTML)
import Halogen.Query (ForkId)

data DefaultDate = First | Last | LastBeforeNow | FirstAfterNow | None

type Item w i = 
  { date :: Date
  , label :: HTML w i
  }

type Input w i =
  { items :: Array (Item w i)
  , loading :: Boolean
  , defaultDate :: DefaultDate
  }

data Output = SelectedDate (Maybe Date)

type Slots :: ∀ k. Row k
type Slots = NoSlots

type State w i = 
  { input :: Input w i
  , selectedItem :: Maybe (Item w i)
  , scrollFork :: Maybe (Ref (Maybe ForkId))
  }

data Action w i
  = Initialize
  | SelectItem (Item w i)
  | SelectItemByDate Date 
  | Receive (Input w i)
  | HandleDocScroll
  | HandleDocScrollEnd

type Query :: ∀ k. k -> Type
type Query = NoQuery

type TimelineM w i a = HalogenM (State w i) (Action w i) Slots Output AppM a

