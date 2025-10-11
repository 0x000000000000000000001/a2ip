module Component.Common.Link.Type
  ( Action(..)
  , Input
  , Output
  , Query
  , Slots
  , State
  )
  where

import Component.Util.Type (NoOutput, NoQuery, NoSlots)

type Input =
  { href :: String
  } 
 
type Output = NoOutput

type Slots :: forall k. Row k
type Slots = NoSlots

type State =
  { href :: String
  }

data Action = Receive Input

type Query :: forall k. k -> Type
type Query = NoQuery