module Component.Common.PrettyErrorImage.Type
  ( Action(..)
  , Input
  , Output
  , Query
  , Slots
  , State
  )
  where

import Component.Util.Type (NoAction, NoInput, NoOutput, NoQuery, NoSlots)

type Input = NoInput

type Output = NoOutput

type Slots :: forall k. Row k
type Slots = NoSlots

type State =
  { errored :: Boolean
  }

type Action = NoAction

type Query :: forall k. k -> Type
type Query = NoQuery