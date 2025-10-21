module Component.Common.Separator.Type
  ( Action(..)
  , ComponentM
  , Input
  , Output(..)
  , Query
  , Slots
  , State
  )
  where

import Capability.AppM (AppM)
import Component.Util.Type (NoOutput, NoQuery, NoSlots)
import Halogen (HalogenM)

type Input = 
  { text :: String
  , loading :: Boolean
  , withSofa :: Boolean
  }

type Output = NoOutput

type Slots :: ∀ k. Row k
type Slots = NoSlots

type State = 
  { text :: String
  , loading :: Boolean
  , withSofa :: Boolean
  }

data Action = Receive Input

type Query :: ∀ k. k -> Type
type Query = NoQuery

type ComponentM a = HalogenM State Action Slots Output AppM a
