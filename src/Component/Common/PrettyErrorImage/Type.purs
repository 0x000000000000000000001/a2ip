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
import DOM.HTML.Indexed (HTMLimg)
import Halogen.HTML (IProp)

type ImageProps i = Array (IProp HTMLimg i)

type Input i =
  { iProps :: ImageProps i
  } 
 
type Output = NoOutput

type Slots :: forall k. Row k
type Slots = NoSlots

type State i =
  { iProps :: ImageProps i
  , errored :: Boolean
  }

data Action = HandleError

type Query :: forall k. k -> Type
type Query = NoQuery