module App.Component.Common.PrettyErrorImage.Type
  ( Action(..)
  , Input
  , Output
  , PrettyErrorImageM
  , Query
  , Slots
  , Sources
  , State
  , Style
  , Try(..)
  , Url
  , defaultInput
  )
  where

import App.Component.Util.Type (NoOutput, NoQuery, NoSlots, MkState)
import App.Util.Capability.AppM (AppM)
import Data.Eq (class Eq)
import Data.Maybe (Maybe(..))
import Halogen (HalogenM)

type Style = 
  { root :: 
      { 
      }
  , questionMark :: 
      { 
      }
  }

type Url = String

type Sources = 
  { first :: Url
  , fallback :: Maybe Url
  }

type Input =
  { class_ :: Maybe String
  , loading :: Boolean
  , sources :: Sources
  , style :: Style
  } 

defaultInput :: Input
defaultInput =
  { class_: Nothing
  , loading: false
  , sources: 
      { first: ""
      , fallback: Nothing
      }
  , style: 
      { root: {}
      , questionMark: {}
      }
  }
 
type Output = NoOutput

type Slots :: ∀ k. Row k
type Slots = NoSlots

data Try = FirstTry Url | FallbackTry Url | StopTrying

derive instance eqTry :: Eq Try

type State = MkState
  ( input :: Input
  , try :: Try
  )

data Action 
  = HandleError
  | Receive Input

type Query :: ∀ k. k -> Type
type Query = NoQuery

type PrettyErrorImageM a = HalogenM State Action Slots Output AppM a
