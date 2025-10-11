module Component.Common.Link.Type
  ( Action(..)
  , Input
  , Output
  , Query
  , Slots
  , State
  )
  where

import Component.Util.Type (NoOutput, NoQuery, NoSlots, Children)

type Input =
  { href :: String
  , children :: Children Action Slots
  } 
 
type Output = NoOutput

type Slots :: forall k. Row k
type Slots = NoSlots

type State =
  { href :: String
  , children :: Children Action Slots
  }

data Action = Receive Input

type Query :: forall k. k -> Type
type Query = NoQuery