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

type ImageProps = forall i. Array (IProp HTMLimg i)

type Input =
  { iProps :: ImageProps
  } 
 
type Output = NoOutput

type Slots :: forall k. Row k
type Slots = NoSlots

type State =
  { iProps :: ImageProps
  , errored :: Boolean
  }

data Action 
  = HandleError
  | ReceiveNewProps ImageProps

type Query :: forall k. k -> Type
type Query = NoQuery