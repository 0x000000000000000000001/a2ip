module App.Component.Common.Modal.Type
  ( Action(..)
  , Input
  , ModalM
  , Output(..)
  , Query
  , Slots
  , State
  )
  where

import App.Component.Util.Type (NoSlotAddressIndex, NoQuery)
import App.Util.Capability.AppM (AppM)
import Halogen (HalogenM, Slot)
import Web.UIEvent.MouseEvent (MouseEvent)

type Input i = 
  { closable :: Boolean
  , open :: Boolean -- Better than conditional rendering: in child arrays, disappearing/reappearing disturbs the lifecycle of the siblings...
  , innerInput :: i
  }

data Output o = Closed | InnerOutputRaised o

type Slots q o = 
  ( inner :: Slot q o NoSlotAddressIndex
  )

type State i = 
  { input :: Input i
  }

data Action i o = Initialize | Receive (Input i) | HandleClick MouseEvent | HandleCloseClick | RaiseInnerOutput o

type Query :: ∀ k. k -> Type
type Query = NoQuery

type ModalM q i o a = HalogenM (State i) (Action i o) (Slots q o) (Output o) AppM a
