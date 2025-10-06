module Component.Page.About.Type where

import Prelude

import Affjax.RequestBody (RequestBody(..))
import Data.Const (Const)
import Data.Maybe (Maybe)

type Input = Unit

type Output = Void

type Slots :: forall k. Row k
type Slots = ()

type State =
  { members :: Array (Maybe Member)
  }

data Action = LoadData

type Query :: forall k. k -> Type
type Query = Const Void

type Member =
  { lastname :: String
  , firstname :: String
  , role :: String
  , job :: String
  , phone :: String
  , email :: String
  , portraitId :: String
  , originalPortraitUrl :: String
  , finalPortraitUrl :: String
  }

lastname :: String 
lastname = "lastname"

firstname :: String 
firstname = "firstname"

role :: String  
role = "role"

job :: String
job = "job"

phone :: String
phone = "phone"

email :: String
email = "email"

portraitId :: String
portraitId = "portraitId"

originalPortraitUrl :: String
originalPortraitUrl = "originalPortraitUrl"

finalPortraitUrl :: String
finalPortraitUrl = "finalPortraitUrl"
