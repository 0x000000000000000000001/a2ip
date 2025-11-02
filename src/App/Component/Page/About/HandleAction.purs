module App.Component.Page.About.HandleAction
  ( handleAction
  , toPerson
  ) where

import Proem

import App.Component.Page.About.Type (AboutM, Action(..), Person, _collaborators, _country, _email, _firstname, _job, _lastname, _members, _phone, _portraitId, _role, collaborators, members)
import App.Component.Util.Remote (fetchModify)
import Halogen (fork)
import Util.Google.Drive (extractPortraitIdFromViewUrl)
import Util.Google.Sheet (Converter, collaboratorsTab, membersTab)
import Util.Html.Clean (untag)

handleAction :: Action -> AboutM Unit
handleAction = case _ of
  Load -> do
    fetchModify _members members membersTab toPerson

    ø $ fork $ fetchModify _collaborators collaborators collaboratorsTab toPerson

toPerson :: Converter Person
toPerson get row =
  let
    portraitId_ = extractPortraitIdFromViewUrl $ untag $ get _portraitId row
  in
    { firstname: get _firstname row
    , lastname: get _lastname row
    , role: get _role row
    , job: get _job row
    , phone: get _phone row
    , email: get _email row
    , country: get _country row
    , portraitId: portraitId_ ??⇒ ""
    }