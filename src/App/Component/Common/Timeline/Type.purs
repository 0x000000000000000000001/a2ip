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

type Item = 
  { date :: Date
  , label :: ∀ w i. HTML w i
  }

type Input =
  { items :: Array Item
  , loading :: Boolean
  , defaultDate :: DefaultDate
  }

data Output = SelectedDate (Maybe Date)

type Slots :: ∀ k. Row k
type Slots = NoSlots

type State = 
  { input :: Input
  , selectedItem :: Maybe Item
  , scrollFork :: Maybe (Ref (Maybe ForkId))
  }

data Action 
  = Initialize
  | SelectItem Item
  | SelectItemByDate Date 
  | Receive Input
  | HandleDocScroll
  | HandleDocScrollEnd

type Query :: ∀ k. k -> Type
type Query = NoQuery

type TimelineM a = HalogenM State Action Slots Output AppM a

