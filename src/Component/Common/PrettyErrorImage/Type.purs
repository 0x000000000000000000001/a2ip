module Component.Common.PrettyErrorImage.Type
  ( Action(..)
  , PrettyErrorImageM
  , Input
  , Output
  , Query
  , Slots
  , State
  )
  where

import Component.Util.Capability.AppM (AppM)
import Component.Util.Type (NoOutput, NoQuery, NoSlots)
import Data.Maybe (Maybe)
import Halogen (HalogenM)

type Input =
  { class_ :: Maybe String
  , src :: Maybe String
  , fallbackSrc :: Maybe String
  } 
 
type Output = NoOutput

type Slots :: ∀ k. Row k
type Slots = NoSlots

type State =
  { class_ :: Maybe String
  , src :: Maybe String
  , fallbackSrc :: Maybe String
  , errorCount :: Int
  }

data Action 
  = HandleError
  | Receive Input

type Query :: ∀ k. k -> Type
type Query = NoQuery

type PrettyErrorImageM a = HalogenM State Action Slots Output AppM a
