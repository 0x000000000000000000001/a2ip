module App.Component.Page.About.HandleAction
  ( fetchCollaborators
  , fetchMembers
  , handleAction
  , toPerson
  ) where

import Proem

import App.Component.Page.About.Type (Action(..), AboutM, Person, country, email, firstname, job, lastname, phone, portraitId, role)
import App.Util.Capability.Log (error)
import Data.Either (Either)
import Data.Maybe (Maybe(..))
import Effect.Aff.Class (class MonadAff)
import Halogen (fork, modify_)
import Util.Google.Drive (extractPortraitIdFromViewUrl)
import Util.Google.Sheet (Converter, collaboratorsTab, fetch, membersTab)
import Util.Html.Clean (untag)

handleAction :: Action -> AboutM Unit
handleAction = case _ of
  Load -> do
    members <- fetchMembers
    members
      ?! (\m -> modify_ _ { members = Just m })
      ⇿ (error ◁ ("Error fetching members: " <> _))

    ø $ fork do
      collaborators <- fetchCollaborators
      collaborators
        ?! (\c -> modify_ _ { collaborators = Just c })
        ⇿ (error ◁ ("Error fetching collaborators: " <> _))

fetchMembers :: ∀ m. MonadAff m => m (Either String (Array Person))
fetchMembers = fetch membersTab toPerson

fetchCollaborators :: ∀ m. MonadAff m => m (Either String (Array Person))
fetchCollaborators = fetch collaboratorsTab toPerson

toPerson :: Converter Person
toPerson getHtmlCell row =
  let
    portraitId_ = extractPortraitIdFromViewUrl $ untag $ getHtmlCell portraitId row
  in
    { firstname: getHtmlCell firstname row
    , lastname: getHtmlCell lastname row
    , role: getHtmlCell role row
    , job: getHtmlCell job row
    , phone: getHtmlCell phone row
    , email: getHtmlCell email row
    , country: getHtmlCell country row
    , portraitId: portraitId_ ??⇒ ""
    }