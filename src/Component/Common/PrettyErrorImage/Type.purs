module Component.Common.PrettyErrorImage.Type
  ( Action(..)
  , ImageProps
  , Input
  , Output
  , Query
  , Slots
  , State
  )
  where

import Component.Util.Type (NoOutput, NoQuery, NoSlots)
import Halogen.HTML (IProp)

type ImageProps r i = Array (IProp r i)

type Input r i =
  { iProps :: ImageProps r i
  } 
 
type Output = NoOutput

type Slots :: forall k. Row k
type Slots = NoSlots

type State r i =
  { iProps :: ImageProps r i
  , errored :: Boolean
  }

data Action = HandleError

type Query :: forall k. k -> Type
type Query = NoQuery