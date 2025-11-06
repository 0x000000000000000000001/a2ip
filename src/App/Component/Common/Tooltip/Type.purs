module App.Component.Common.Tooltip.Type
  ( Action(..)
  , Input
  , TooltipM
  , Output(..)
  , Query
  , Slots
  , State
  )
  where

import App.Component.Util.Type (NoSlotAddressIndex, NoQuery)
import App.Util.Capability.AppM (AppM)
import Halogen (HalogenM, Slot)

type Input i = 
  { innerInput :: i
  }

data Output o = Closed | InnerOutputRaised o

type Slots q o = 
  ( inner :: Slot q o NoSlotAddressIndex
  )

type State i = 
  { input :: Input i
  , open :: Boolean
  }

data Action i o = Initialize | Receive (Input i) | RaiseInnerOutput o

type Query :: ∀ k. k -> Type
type Query = NoQuery

type TooltipM q i o a = HalogenM (State i) (Action i o) (Slots q o) (Output o) AppM a
