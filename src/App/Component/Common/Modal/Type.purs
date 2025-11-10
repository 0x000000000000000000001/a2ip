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

import App.Component.Util.Type (NoQuery, NoSlotAddressIndex, WithId)
import App.Util.Capability.AppM (AppM)
import Halogen (HalogenM, Slot)
import Web.UIEvent.MouseEvent (MouseEvent)

type Input i = 
  { closable :: Boolean
  -- Better than conditional rendering: in child-arrays, disappearing/reappearing 
  -- may slightly disturb the rerendering flow and the inner workings of 
  -- the siblings (e.g. ones with iframes)
  , open :: Boolean 
  , innerInput :: i
  }

data Output o = Closed | InnerOutputRaised o

type Slots q o = 
  ( inner :: Slot q o NoSlotAddressIndex
  )

type State i = WithId
  ( input :: Input i
  )

data Action i o = Initialize | Receive (Input i) | HandleClick MouseEvent | HandleCloseClick | RaiseInnerOutput o

type Query :: ∀ k. k -> Type
type Query = NoQuery

type ModalM q i o a = HalogenM (State i) (Action i o) (Slots q o) (Output o) AppM a
