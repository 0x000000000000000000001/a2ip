module Component.Common.Separator.Type
  ( Action(..)
  , Input
  , Output(..)
  , Query
  , SeparatorM
  , Slots
  , State
  , TextElementTag(..)
  )
  where

import Capability.AppM (AppM)
import Component.Util.Type (NoOutput, NoQuery, NoSlots)
import Halogen (HalogenM)

data TextElementTag = H1 | H2 | H3 | Div

type Input = 
  { text :: String
  , textElementTag :: TextElementTag
  , loading :: Boolean
  , withSofa :: Boolean
  }

type Output = NoOutput

type Slots :: ∀ k. Row k
type Slots = NoSlots

type State = 
  { text :: String
  , textElementTag :: TextElementTag
  , loading :: Boolean
  , withSofa :: Boolean
  }

data Action = Receive Input

type Query :: ∀ k. k -> Type
type Query = NoQuery

type SeparatorM a = HalogenM State Action Slots Output AppM a
