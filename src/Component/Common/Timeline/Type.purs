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

import Proem (class Eq)
import Component.Util.Type (NoQuery, NoSlots)
import Data.Maybe (Maybe)
import Data.Newtype (class Newtype)

newtype Date = Date
  { day :: Int
  , month :: Int
  , year :: Int
  }

derive instance newtypeDate :: Newtype Date _
derive instance eqDate :: Eq Date

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
  }

data Action = SelectDate Date | Receive Input

type Query :: ∀ k. k -> Type
type Query = NoQuery