module Component.Common.Timeline.Type
  ( Action(..)
  , Date
  , Input
  , Output(..)
  , Query
  , Slots
  , State
  )
  where

import Component.Util.Type (NoOutput, NoQuery, NoSlots)
import Data.Maybe (Maybe)

type Date = 
  { day :: Int 
  , month :: Int
  , year :: Int
  }

type Input = 
  { class_ :: Maybe String
  , dates :: Array Date
  }

type Output = NoOutput

type Slots :: ∀ k. Row k
type Slots = NoSlots

type State = 
  { class_ :: Maybe String
  , dates :: Array Date
  }

data Action = Receive Input

type Query :: ∀ k. k -> Type
type Query = NoQuery