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

import App.Component.Common.Input.Type as Input
import App.Component.Util.Type (NoSlotAddressIndex, NoQuery)
import App.Util.Capability.AppM (AppM)
import Halogen (HalogenM, Slot)

type Input i = 
  { innerInput :: i
  , password :: String
  }

data Output o = InnerOutputRaised o

type Slots q o = 
  ( inner :: Slot q o NoSlotAddressIndex
  , password :: Slot Input.Query Input.Output NoSlotAddressIndex
  )

type State i = 
  { innerInput :: i
  , unlocking :: Boolean
  }

data Action i o = Receive (Input i) | RaiseInnerOutput o | DoNothing

type Query :: ∀ k. k -> Type
type Query = NoQuery

type VaultM q i o a = HalogenM (State i) (Action i o) (Slots q o) (Output o) AppM a
