module Component.Page.About.Type where

import Prelude

import Data.Maybe (Maybe)
import Data.Const (Const)

type Input = Unit

type Output = Void

type Slots :: forall k. Row k
type Slots = ()

type State =
  { isLoading :: Boolean
  , data :: Maybe (Array (Array String))
  }

-- Component actions
data Action
  = LoadData

type Query :: forall k. k -> Type
type Query = Const Void
