module Component.Common.Separator.Type
  ( Action(..)
  , Input
  , Output(..)
  , Query
  , Slots
  , State
  )
  where

import Component.Util.Type (NoOutput, NoQuery, NoSlots)

type Input = 
  { text :: String
  , loading :: Boolean
  }

type Output = NoOutput

type Slots :: ∀ k. Row k
type Slots = NoSlots

type State = 
  { text :: String
  , loading :: Boolean
  }

data Action = Receive Input

type Query :: ∀ k. k -> Type
type Query = NoQuery