module Component.Page.About.Type   where


import Component.Common.PrettyErrorImage.Type as PrettyErrorImage
import Component.Common.Separator.Type as Separator
import Component.Util.Type (NoInput, NoOutput, NoQuery)
import Data.Maybe (Maybe)
import Halogen (Slot)
import Type.Prelude (Proxy(..))

type Input = NoInput

type Output = NoOutput

type Slots =
  ( portraits :: Slot PrettyErrorImage.Query PrettyErrorImage.Output String
  , separators :: Slot Separator.Query Separator.Output String
  )

portraits = Proxy :: Proxy "portraits"
separators = Proxy :: Proxy "separators"

members :: String
members = "members"

collaborators :: String
collaborators = "collaborators"

type State =
  { members :: Maybe (Array Member)
  , collaborators :: Maybe (Array Collaborator)
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

type Collaborator = String

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

country :: String
country = "country"