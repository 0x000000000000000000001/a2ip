module Component.Common.PrettyErrorImage.Type
  ( Action(..)
  , Input
  , Output
  , Query
  , Slots
  , State
  )
  where

import Component.Util.Type (NoOutput, NoQuery, NoSlots)
import Data.Maybe (Maybe)

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
  , fallbacked :: Boolean
  , errored :: Boolean
  }

data Action 
  = HandleError
  | Receive Input

type Query :: ∀ k. k -> Type
type Query = NoQuery