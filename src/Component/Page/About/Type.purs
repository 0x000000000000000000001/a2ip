module Component.Page.About.Type where

import Prelude

import Data.Maybe (Maybe)
import Data.Const (Const)
import Effect.Exception (Error)

type Input = Unit

type Output = Void

type Slots :: forall k. Row k
type Slots = ()

-- Sheet data structure
type SheetData =
  { title :: String
  , rows :: Array (Array String)
  }

-- Component state
type State =
  { isLoading :: Boolean
  , sheetData :: Maybe SheetData
  , error :: Maybe String
  }

-- Component actions
data Action
  = Initialize
  | LoadSheetData
  | SheetDataLoaded SheetData
  | SheetDataFailed Error

type Query :: forall k. k -> Type
type Query = Const Void
