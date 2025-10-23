module App.Component.Page.About.Type   where


import App.Util.Capability.AppM.AppM (AppM)
import App.Component.Common.PrettyErrorImage.Type as PrettyErrorImage
import App.Component.Common.Separator.Type as Separator
import App.Component.Util.Type (NoInput, NoOutput, NoQuery)
import Data.Maybe (Maybe)
import Halogen (HalogenM, Slot)
import Type.Prelude (Proxy(..))

type Input = NoInput

type Output = NoOutput

type Slots =
  ( portraits :: Slot PrettyErrorImage.Query PrettyErrorImage.Output String
  , separators :: Slot Separator.Query Separator.Output String
  )

portraits = Proxy :: Proxy "portraits"
separators = Proxy :: Proxy "separators"

type State =
  { members :: Maybe (Array Person)
  , collaborators :: Maybe (Array Person)
  }

members = Proxy :: Proxy "members"
collaborators = Proxy :: Proxy "collaborators"

data Action = Load

type Query :: ∀ k. k -> Type
type Query = NoQuery

type AboutM a = HalogenM State Action Slots Output AppM a

type PersonRow = 
  ( lastname :: String
  , firstname :: String
  , role :: String
  , job :: String
  , phone :: String
  , email :: String
  , portraitId :: String
  , country :: String
  )

type Person = { | PersonRow }

lastname = Proxy :: Proxy "lastname" 
firstname = Proxy :: Proxy "firstname"
role = Proxy :: Proxy "role"
job = Proxy :: Proxy "job"
phone = Proxy :: Proxy "phone"
email = Proxy :: Proxy "email"
portraitId = Proxy :: Proxy "portraitId"
country = Proxy :: Proxy "country"