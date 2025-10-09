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

type Input p =
  { iProps :: p
  } 

type Output = NoOutput

type Slots :: forall k. Row k
type Slots = NoSlots

type State p =
  { errored :: Boolean
  , iProps :: p
  }

data Action = HandleError

type Query :: forall k. k -> Type
type Query = NoQuery