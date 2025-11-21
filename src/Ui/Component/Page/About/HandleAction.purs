module Ui.Component.Page.About.HandleAction
  ( handleAction
  , toPerson
  ) where

import Proem

import Ui.Component.Page.About.Type (AboutM, Action(..), Person, _collaborators, _members)
import Ui.Component.Util.Remote (fetchModify)
import Halogen (fork)
import Util.Google.Drive (extractPortraitIdFromViewUrl)
import Util.Google.Sheet (Converter)
import Util.Html.Clean (untag)
import Util.Proxy.Dictionary.Collaborators (collaborators')
import Util.Proxy.Dictionary.Country (country')
import Util.Proxy.Dictionary.Email (email')
import Util.Proxy.Dictionary.Firstname (firstname')
import Util.Proxy.Dictionary.Job (job')
import Util.Proxy.Dictionary.Lastname (lastname')
import Util.Proxy.Dictionary.Members (members')
import Util.Proxy.Dictionary.Phone (phone')
import Util.Proxy.Dictionary.PortraitId (portraitId')
import Util.Proxy.Dictionary.Role (role')

handleAction :: Action -> AboutM Unit
handleAction = case _ of
  Load -> do
    fetchModify members' _members toPerson identity

    ø $ fork $ fetchModify collaborators' _collaborators toPerson identity

toPerson :: Converter Person
toPerson get row =
  let
    portraitId_ = extractPortraitIdFromViewUrl $ untag $ get portraitId' row
  in
    { firstname: get firstname' row
    , lastname: get lastname' row
    , role: get role' row
    , job: get job' row
    , phone: get phone' row
    , email: get email' row
    , country: get country' row
    , portraitId: portraitId_ ??⇒ ""
    }