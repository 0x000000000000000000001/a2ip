module Ui.Component.Page.About.Type   where


import Ui.Component.Common.PrettyErrorImage.Type as PrettyErrorImage
import Ui.Component.Common.Separator.Type as Separator
import Ui.Component.Util.Type (Remote, NoInput, NoOutput, NoQuery)
import Ui.Util.Capability.AppM (AppM)
import Data.Lens (Lens')
import Data.Lens.Record (prop)
import Halogen (HalogenM, Slot)
import Util.Proxy.Dictionary.Collaborators (collaborators')
import Util.Proxy.Dictionary.Members (members')

type Input = NoInput

type Output = NoOutput

type Slots =
  ( portraits :: Slot PrettyErrorImage.Query PrettyErrorImage.Output String
  , separators :: Slot Separator.Query Separator.Output String
  )

type Members = Remote (Array Person)
type Collaborators = Remote (Array Person)

type State =
  { members :: Members
  , collaborators :: Collaborators
  }

_members = prop members' :: Lens' State Members
_collaborators = prop collaborators' :: Lens' State Collaborators

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
  , country :: String
  )

type Person = { | PersonRow }
