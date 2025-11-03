module App.Component.Common.Vault.Type
  ( Action(..)
  , Input
  , VaultM
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

data Output o = InnerOutputRaised o

type Slots q o = 
  ( inner :: Slot q o NoSlotAddressIndex
  )

type State i = 
  { innerInput :: i
  }

data Action i o = Receive (Input i) | RaiseInnerOutput o

type Query :: ∀ k. k -> Type
type Query = NoQuery

type VaultM q i o a = HalogenM (State i) (Action i o) (Slots q o) (Output o) AppM a
