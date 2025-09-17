module Component.Page.About.Render where

import Prelude hiding (div)

import Capability.Log (class Log)
import Capability.Navigate (class Navigate)
import Component.Page.About.Type (Action, State, Slots, Member)
import Data.Maybe (Maybe(..))
import Data.String (Pattern(..), Replacement(..), replace)
import Effect.Aff.Class (class MonadAff)
import Halogen as H
import Halogen.HTML (div_, h3_, img, p_, text)
import Halogen.HTML as HH
import Halogen.HTML.Properties (src)

googleDriveImageUrlTemplatePlaceholder :: String
googleDriveImageUrlTemplatePlaceholder = "__FILE_ID__"
 
googleDriveImageUrlTemplate :: String 
googleDriveImageUrlTemplate = "https://www.googleapis.com/drive/v3/files/" <> googleDriveImageUrlTemplatePlaceholder <> "?alt=media&key=AIzaSyCe9sioL_5aL3-XrdFfU7AuavfhDZMnQeo"

generateGoogleDriveImageUrl :: String -> String
generateGoogleDriveImageUrl id = replace (Pattern googleDriveImageUrlTemplatePlaceholder) (Replacement id) googleDriveImageUrlTemplate

render :: forall m. MonadAff m => Navigate m => Log m => State -> H.ComponentHTML Action Slots m
render state =
  case state.data of
    Nothing -> 
      if state.isLoading 
        then text "Loading..."
        else text ""
    
    Just members -> 
      div_ (map renderMemberCard members)

renderMemberCard :: forall w i. Member -> HH.HTML w i
renderMemberCard member =
  div_
    [ h3_ [ text $ member.firstname <> " " <> member.lastname ]
    , img [ src $ generateGoogleDriveImageUrl member.portraitId ]
    , p_ [ text $ "Role: " <> member.role ]
    , p_ [ text $ "Job: " <> member.job ]
    , p_ [ text $ "Phone: " <> member.phone ]
    , p_ [ text $ "Email: " <> member.email ]
    ]
