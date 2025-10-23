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

import Proem
import Component.Util.Capability.AppM (AppM)
import Component.Util.Type (NoOutput, NoQuery, NoSlots)
import Data.Generic.Rep (class Generic)
import Data.Show.Generic (genericShow)
import Halogen (HalogenM)

data TextElementTag = H1 | H2 | H3 | Div

derive instance genericTextElementTag :: Generic TextElementTag _
instance showTextElementTag :: Show TextElementTag where
  show = genericShow

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
