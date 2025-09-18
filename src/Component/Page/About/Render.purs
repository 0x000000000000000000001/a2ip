module Component.Page.About.Render
  ( render
  ) where

import Prelude hiding (div)

import Capability.Log (class Log)
import Capability.Navigate (class Navigate)
import Component.Page.About.Style.About (classId)
import Component.Page.About.Style.Card.Card as Card
import Component.Page.About.Style.Card.Line as CardLine
import Component.Page.About.Style.Card.Names as CardNames
import Component.Page.About.Style.Card.Portrait as CardPortrait
import Component.Page.About.Style.Sheet (sheet)
import Component.Page.About.Type (Action, State, Slots, Member)
import Data.Array (filter, replicate)
import Data.Maybe (Maybe, maybe)
import Data.String (Pattern(..), Replacement(..), replace)
import Effect.Aff.Class (class MonadAff)
import Halogen as H
import Halogen.HTML (div, img, text)
import Halogen.HTML as HH
import Halogen.HTML.Properties (src)
import Utils.Style (class_, classes)

googleDriveImageUrlTemplatePlaceholder :: String
googleDriveImageUrlTemplatePlaceholder = "__FILE_ID__"

googleDriveImageUrlTemplate :: String
googleDriveImageUrlTemplate = "https://www.googleapis.com/drive/v3/files/" <> googleDriveImageUrlTemplatePlaceholder <> "?alt=media&key=AIzaSyCe9sioL_5aL3-XrdFfU7AuavfhDZMnQeo"

generateGoogleDriveImageUrl :: String -> String
generateGoogleDriveImageUrl id = replace (Pattern googleDriveImageUrlTemplatePlaceholder) (Replacement id) googleDriveImageUrlTemplate

mockImageUrl :: String
mockImageUrl = "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/011_The_lion_king_Tryggve_in_the_Serengeti_National_Park_Photo_by_Giles_Laurent.jpg/960px-011_The_lion_king_Tryggve_in_the_Serengeti_National_Park_Photo_by_Giles_Laurent.jpg"

render :: forall m. MonadAff m => Navigate m => Log m => State -> H.ComponentHTML Action Slots m
render state =
  div
    [ class_ classId ]
    ([ sheet ] <> (map renderMemberCard state.members))

loadingTextPlaceholder :: String
loadingTextPlaceholder = "__loading_text__"

renderMemberCard :: forall w i. Maybe Member -> HH.HTML w i
renderMemberCard member =
  div
    [ classes $
        [ Card.classId ]
          <> if isLoading then [ Card.classIdWhenLoading ] else []
    ]
    ( [ div [ class_ CardNames.classId ] [ text $ maybe loadingTextPlaceholder (\m -> m.firstname <> " " <> m.lastname) member ]
      -- , img [ src $ generateGoogleDriveImageUrl member.portraitId ]
      , img ([ class_ CardPortrait.classId ] <> if isLoading then [] else [ src $ mockImageUrl ])
      ] <>
        ( (\i -> div [ class_ CardLine.classId ] [ text i ])
            <$>
              maybe (replicate 4 loadingTextPlaceholder) (\m -> [ m.role, m.job, m.phone, m.email ] # filter (_ /= "")) member
        )
    )
  where
  isLoading = maybe true (const false) member
