module Component.Common.PrettyErrorImage.Type
  ( Action(..)
  , Input
  , Output
  , Query
  , Slots
  , State
  )
  where

import Component.Util.Type (NoOutput, NoQuery, NoSlots)

type Input i =
  { iProps :: i
  } 

type Output = NoOutput

type Slots :: forall k. Row k
type Slots = NoSlots

type State i =
  { iProps :: i
  , errored :: Boolean
  }

data Action = HandleError

type Query :: forall k. k -> Type
type Query = NoQuery