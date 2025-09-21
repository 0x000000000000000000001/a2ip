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
import Component.Page.About.Type (Action, Member, Slots, State, email, job, phone, role)
import Data.Maybe (Maybe(..), fromMaybe, maybe)
import Data.String (Pattern(..), Replacement(..), replace)
import Data.String as String
import Effect.Aff.Class (class MonadAff)
import Halogen as H
import Halogen.HTML (div, img, text, a)
import Halogen.HTML.Properties (href, target, src)
import Utils.Style (class_, classes)

mockImages :: Boolean
mockImages = true

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

loadingPlaceholder :: String
loadingPlaceholder = "__loading__"

renderMemberCard :: forall m. Maybe Member -> H.ComponentHTML Action Slots m
renderMemberCard member =
  div
    [ classes $
        [ Card.classId ]
          <> if isLoading then [ Card.classIdWhenLoading ] else [ Card.classIdWhenLoaded ]
    ]
    ( [ div
          [ class_ CardNames.classId ]
          [ text $ maybe loadingPlaceholder (\m -> m.firstname <> " " <> m.lastname) member ]
      , img
          ( [ class_ CardPortrait.classId ]
              <> if isLoading then [] else [ src $ if mockImages then mockImageUrl else generateGoogleDriveImageUrl $ maybe "" _.portraitId member ]
          )
      ] <> lines
    )
  where
  member_ :: Member
  member_ = fromMaybe
    { lastname: loadingPlaceholder
    , firstname: loadingPlaceholder
    , role: loadingPlaceholder
    , job: loadingPlaceholder
    , phone: loadingPlaceholder
    , email: loadingPlaceholder
    , portraitId: loadingPlaceholder
    }
    member

  isLoading = maybe true (const false) member

  line getter key =
    if not isLoading && getter member_ == "" then []
    else
      [ div
          [ classes [ CardLine.classId, CardLine.classIdWhen key ] ]
          [ renderContent $ getter member_ ]
      ]
  
  renderContent :: forall n. String -> H.ComponentHTML Action Slots n  
  renderContent content =
    case parseLink content of
      Just { before, linkText, linkUrl, after } ->
        div []
          [ text before
          , a [ href linkUrl, target "_blank" ] [ text linkText ]
          , text after
          ]
      Nothing -> text content
  
  parseLink :: String -> Maybe { before :: String, linkText :: String, linkUrl :: String, after :: String }
  parseLink str =
    case String.indexOf (String.Pattern "<a href=\"") str of
      Just startIdx ->
        let before = String.take startIdx str
            afterStart = String.drop startIdx str
        in case String.indexOf (String.Pattern "\">") afterStart of
          Just closeQuoteIdx ->
            let linkUrl = String.take (closeQuoteIdx - 9) (String.drop 9 afterStart)
                afterLinkStart = String.drop (closeQuoteIdx + 2) afterStart
            in case String.indexOf (String.Pattern "</a>") afterLinkStart of
              Just linkEndIdx ->
                let linkText = String.take linkEndIdx afterLinkStart
                    after = String.drop (linkEndIdx + 4) afterLinkStart
                in Just { before, linkText, linkUrl, after }
              Nothing -> Nothing
          Nothing -> Nothing
      Nothing -> Nothing

  lines =
    line _.role role
      <> line _.job job
      <> line _.phone phone
      <> line _.email email
