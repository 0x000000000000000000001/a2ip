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
import Halogen.HTML (IProp)

type Input =
  { innerProps :: forall (w :: Row Type). Array (IProp w Action)
  }

type Output = NoOutput

type Slots :: forall k. Row k
type Slots = NoSlots

type State =
  { errored :: Boolean
  , innerProps :: forall (w :: Row Type). Array (IProp w Action)
  }

data Action = HandleError

type Query :: forall k. k -> Type
type Query = NoQuery