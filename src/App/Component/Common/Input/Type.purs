module App.Component.Common.Input.Type
  ( Action(..)
  , InputM
  , Input
  , Output(..)
  , Query
  , Slots
  , State
  , defaultInput
  )
  where

import App.Component.Util.Type (NoQuery, NoSlots)
import App.Util.Capability.AppM (AppM)
import Data.Maybe (Maybe(..))
import Effect.Ref (Ref)
import Halogen (HalogenM)

type Input =
  { placeholder :: Maybe String
  , label :: Maybe String
  , initialValue :: String
  , class_ :: Maybe String
  } 

defaultInput :: Input
defaultInput = 
  { placeholder: Nothing
  , label: Nothing
  , initialValue: ""
  , class_: Nothing
  }
 
data Output = ChangedValue String

type Slots :: ∀ k. Row k
type Slots = NoSlots

type State =
  { input :: Input
  , value :: Maybe (Ref String)
  }

data Action 
  = Initialize
  | Receive Input
  | HandleInput String

type Query :: ∀ k. k -> Type
type Query = NoQuery

type InputM = HalogenM State Action Slots Output AppM
