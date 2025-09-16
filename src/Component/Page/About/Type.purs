module Component.Page.About.Type where

import Prelude

import Data.Maybe (Maybe)
import Data.Const (Const)

type Input = Unit

type Output = Void

type Slots :: forall k. Row k
type Slots = ()

type Data =
  { title :: String
  , rows :: Array (Array String)
  }

type State =
  { isLoading :: Boolean
  , data :: Maybe Data
  , error :: Maybe String
  }

-- Component actions
data Action
  = LoadSheetData

type Query :: forall k. k -> Type
type Query = Const Void
