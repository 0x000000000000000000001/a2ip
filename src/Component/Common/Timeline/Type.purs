module Component.Common.Timeline.Type
  ( Action(..)
  , Date(..)
  , Input
  , Output(..)
  , Query
  , Slots
  , State
  )
  where

import Proem

import Component.Util.Type (NoQuery, NoSlots)
import Data.Generic.Rep (class Generic)
import Data.Maybe (Maybe)
import Data.Newtype (class Newtype)
import Data.Show.Generic (genericShow)
import Halogen.Query (ForkId)

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
  }

data Output = SelectedDate Date

type Slots :: ∀ k. Row k
type Slots = NoSlots

type State = 
  { class_ :: Maybe String
  , dates :: Array Date
  , selectedDate :: Maybe Date
  , scrollFork :: Maybe ForkId
  }

data Action 
  = Initialize
  | Finalize
  | SelectDate Date 
  | Receive Input
  | HandleScroll
  | HandleScrollEnd

type Query :: ∀ k. k -> Type
type Query = NoQuery