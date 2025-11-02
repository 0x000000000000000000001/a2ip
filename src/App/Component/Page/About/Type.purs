module App.Component.Page.About.Type   where


import App.Component.Common.PrettyErrorImage.Type as PrettyErrorImage
import App.Component.Common.Separator.Type as Separator
import App.Component.Util.Type (Remote, NoInput, NoOutput, NoQuery)
import App.Util.Capability.AppM (AppM)
import Data.Lens (Lens')
import Data.Lens.Record (prop)
import Halogen (HalogenM, Slot)
import Type.Prelude (Proxy(..))

type Input = NoInput

type Output = NoOutput

type Slots =
  ( portraits :: Slot PrettyErrorImage.Query PrettyErrorImage.Output String
  , separators :: Slot Separator.Query Separator.Output String
  )

_portraits = Proxy :: Proxy "portraits"
_separators = Proxy :: Proxy "separators"

type State =
  { members :: Remote (Array Person)
  , collaborators :: Remote (Array Person)
  }

_members = Proxy :: Proxy "members"
members = prop _members :: Lens' State (Remote (Array Person))
_collaborators = Proxy :: Proxy "collaborators"
collaborators = prop _collaborators :: Lens' State (Remote (Array Person))

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

_lastname = Proxy :: Proxy "lastname" 
_firstname = Proxy :: Proxy "firstname"
_role = Proxy :: Proxy "role"
_job = Proxy :: Proxy "job"
_phone = Proxy :: Proxy "phone"
_email = Proxy :: Proxy "email"
_portraitId = Proxy :: Proxy "portraitId"
_country = Proxy :: Proxy "country"