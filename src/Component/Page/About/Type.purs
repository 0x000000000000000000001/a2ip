module Component.Page.About.Type where

import Prelude

import Data.Maybe (Maybe)
import Data.Const (Const)

type Input = Unit

type Output = Void

type Slots :: forall k. Row k
type Slots = ()

type Member =
  { lastname :: String
  , firstname :: String
  , role :: String
  , job :: String
  , phone :: String
  , email :: String
  , portraitId :: String
  }

type State =
  { isLoading :: Boolean
  , data :: Maybe (Array Member)
  }

data Action = LoadData

type Query :: forall k. k -> Type
type Query = Const Void
