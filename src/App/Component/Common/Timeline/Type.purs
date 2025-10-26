module App.Component.Common.Timeline.Type
  ( Action(..)
  , TimelineM
  , Date(..)
  , Input
  , Output(..)
  , Query
  , Slots
  , State
  , date
  )
  where

import Proem

import App.Util.Capability.AppM (AppM)
import App.Component.Util.Type (NoQuery, NoSlots)
import Data.Generic.Rep (class Generic)
import Data.Maybe (Maybe)
import Data.Newtype (class Newtype)
import Data.Show.Generic (genericShow)
import Halogen (HalogenM)
import Halogen.Query (ForkId)
import Type.Prelude (Proxy(..))

newtype Date = Date
  { day :: Int
  , month :: Int
  , year :: Int
  }

derive instance newtypeDate :: Newtype Date _
derive instance eqDate :: Eq Date
derive instance genericDate :: Generic Date _
instance showDate :: Show Date where
  show = genericShow

type Input =
  { class_ :: Maybe String
  , dates :: Array Date
  , loading :: Boolean
  }

data Output = SelectedDate Date

type Slots :: ∀ k. Row k
type Slots = NoSlots

type State = 
  { class_ :: Maybe String
  , dates :: Array Date
  , selectedDate :: Maybe Date
  , scrollFork :: Maybe ForkId
  , loading :: Boolean
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

date = Proxy :: Proxy "date"
