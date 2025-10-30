module App.Component.Common.PrettyErrorImage.Type
  ( Action(..)
  , Input
  , Output
  , PrettyErrorImageM
  , Query
  , Slots
  , Sources
  , State
  , Try(..)
  , Url
  )
  where

import App.Component.Util.Type (NoOutput, NoQuery, NoSlots)
import App.Util.Capability.AppM (AppM)
import Data.Eq (class Eq)
import Data.Maybe (Maybe)
import Halogen (HalogenM)

type Url = String

type Sources = 
  { first :: Url
  , fallback :: Maybe Url
  }

type Input =
  { class_ :: Maybe String
  , sources :: Maybe Sources
  } 
 
type Output = NoOutput

type Slots :: ∀ k. Row k
type Slots = NoSlots

data Try = FirstTry Url | FallbackTry Url | StopTrying

derive instance eqTry :: Eq Try

type State =
  { class_ :: Maybe String
  , try :: Maybe Try
  , input :: Maybe Input
  }

data Action 
  = HandleError
  | Receive Input

type Query :: ∀ k. k -> Type
type Query = NoQuery

type PrettyErrorImageM a = HalogenM State Action Slots Output AppM a
