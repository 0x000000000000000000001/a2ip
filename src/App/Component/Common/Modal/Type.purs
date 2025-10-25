module App.Component.Common.Modal.Type
  ( Action(..)
  , Input
  , ModalM
  , Output(..)
  , Query
  , Slots
  , State
  , inner
  )
  where

import App.Component.Util.Type (NoSlotAddressIndex, NoQuery)
import App.Util.Capability.AppM (AppM)
import Halogen (HalogenM, Slot)
import Type.Prelude (Proxy(..))
import Web.UIEvent.MouseEvent (MouseEvent)

type Input i = 
  { closable :: Boolean
  , innerInput :: i
  }

data Output o = Closed | InnerOutput o

type Slots q o = 
  ( inner :: Slot q o NoSlotAddressIndex
  )

inner = Proxy :: Proxy "inner"

type State i = 
  { closable :: Boolean
  , innerInput :: i
  }

data Action i = Receive (Input i) | HandleClick MouseEvent | HandleCloseClick

type Query :: ∀ k. k -> Type
type Query = NoQuery

type ModalM q i o a = HalogenM (State i) (Action i) (Slots q o) (Output o) AppM a
