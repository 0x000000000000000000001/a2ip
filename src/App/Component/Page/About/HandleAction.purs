module App.Component.Page.About.HandleAction
  ( fetchCollaborators
  , fetchMembers
  , handleAction
  , toPerson
  ) where

import Proem

import App.Component.Page.About.Type (Action(..), AboutM, Person, _country, _email, _firstname, _job, _lastname, _phone, _portraitId, _role)
import App.Util.Capability.Log (error)
import Data.Either (Either)
import Effect.Aff.Class (class MonadAff)
import Halogen (fork, modify_)
import Network.RemoteData (RemoteData(..))
import Util.Google.Drive (extractPortraitIdFromViewUrl)
import Util.Google.Sheet (Converter, collaboratorsTab, fetch, membersTab)
import Util.Html.Clean (untag)

handleAction :: Action -> AboutM Unit
handleAction = case _ of
  Load -> do
    modify_ _ { members = Loading }
    members <- fetchMembers
    members
      ?! (\m -> modify_ _ { members = Success m })
      ⇿ (\e -> do
          error $ "Error fetching members: " <> e
          modify_ _ { members = Failure e }
      )

    ø $ fork do
      modify_ _ { collaborators = Loading }
      collaborators <- fetchCollaborators
      collaborators
        ?! (\c -> modify_ _ { collaborators = Success c })
        ⇿ (\e -> do
            error $ "Error fetching collaborators: " <> e
            modify_ _ { collaborators = Failure e }
        )

fetchMembers :: ∀ m. MonadAff m => m (Either String (Array Person))
fetchMembers = fetch membersTab toPerson

fetchCollaborators :: ∀ m. MonadAff m => m (Either String (Array Person))
fetchCollaborators = fetch collaboratorsTab toPerson

toPerson :: Converter Person
toPerson getHtmlCell row =
  let
    portraitId_ = extractPortraitIdFromViewUrl $ untag $ getHtmlCell _portraitId row
  in
    { firstname: getHtmlCell _firstname row
    , lastname: getHtmlCell _lastname row
    , role: getHtmlCell _role row
    , job: getHtmlCell _job row
    , phone: getHtmlCell _phone row
    , email: getHtmlCell _email row
    , country: getHtmlCell _country row
    , portraitId: portraitId_ ??⇒ ""
    }