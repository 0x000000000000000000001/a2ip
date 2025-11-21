module Ui.Component.Common.Vault.Type
  ( Action(..)
  , Input
  , LockedState
  , Output(..)
  , Phase(..)
  , Query
  , Slots
  , State
  , VaultM
  , _Locked
  , _Unlocked
  , _Unlocking
  , isLocked
  , isUnlocked
  , isUnlocking
  )
  where

import Proem

import Ui.Component.Common.Input.Type as Input
import Ui.Component.Util.Type (NoSlotAddressIndex, NoQuery)
import Ui.Util.Capability.AppM (AppM)
import Data.Either (Either(..))
import Data.Lens (Prism', prism)
import Data.Maybe (Maybe)
import Effect.Ref (Ref)
import Halogen (HalogenM, Slot)

type Input i = 
  { innerInput :: i
  , memoId :: String -- Every vault associated with this ID will remember "password successfully entered"
  , password :: String
  }

data Output o = InnerOutputRaised o

type Slots q o = 
  ( inner :: Slot q o NoSlotAddressIndex
  , password :: Slot Input.Query Input.Output NoSlotAddressIndex
  )

type LockedState = 
  { passwordInputValue :: Maybe (Ref String)
  , incorrect :: Boolean 
  }

data Phase 
  = Locked LockedState
  | Unlocking 
  | Unlocked

instance showPhase :: Show Phase where
  show (Locked _) = "Locked"
  show Unlocking = "Unlocking"
  show Unlocked = "Unlocked"

isLocked :: Phase -> Boolean
isLocked (Locked _) = true
isLocked _ = false

isUnlocking :: Phase -> Boolean
isUnlocking Unlocking = true
isUnlocking _ = false

isUnlocked :: Phase -> Boolean
isUnlocked Unlocked = true
isUnlocked _ = false

_Unlocking :: Prism' Phase Unit
_Unlocking = prism (κ Unlocking) unwrap
  where
  unwrap Unlocking = Right ι
  unwrap y = Left y

_Unlocked :: Prism' Phase Unit
_Unlocked = prism (κ Unlocked) unwrap
  where
  unwrap Unlocked = Right ι
  unwrap y = Left y

_Locked :: Prism' Phase LockedState
_Locked = prism Locked unwrap
  where
  unwrap (Locked x) = Right x
  unwrap y = Left y

type State i = 
  { input :: Input i
  , phase :: Phase
  }

data Action i o 
  = Initialize
  | Receive (Input i) 
  | RaiseInnerOutput o 
  | DoNothing 
  | HandleSubmit
  | HandleNewPasswordInputValue String

type Query :: ∀ k. k -> Type
type Query = NoQuery

type VaultM q i o a = HalogenM (State i) (Action i o) (Slots q o) (Output o) AppM a
