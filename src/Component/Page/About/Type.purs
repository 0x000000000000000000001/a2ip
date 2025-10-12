module Component.Page.About.Type   where


import Component.Util.Type (NoInput, NoOutput, NoQuery)
import Data.Maybe (Maybe)
import Halogen (Slot)
import Component.Common.PrettyErrorImage.Type as PrettyErrorImage

type Input = NoInput

type Output = NoOutput

type Slots =
  ( prettyErrorImage :: Slot PrettyErrorImage.Query PrettyErrorImage.Output String
  )

type State =
  { members :: Array (Maybe Member)
  }

data Action = LoadData

type Query :: ∀ k. k -> Type
type Query = NoQuery

type Member =
  { lastname :: String
  , firstname :: String
  , role :: String
  , job :: String
  , phone :: String
  , email :: String
  , portraitId :: String
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