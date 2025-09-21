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
import Halogen.HTML (div, img, text, a, span_, strong_, em_, p_)
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
  renderContent content = renderHtml content
  
  renderHtml :: forall n. String -> H.ComponentHTML Action Slots n
  renderHtml htmlString = 
    case parseHtmlElement htmlString of
      Just elements -> div [] elements
      Nothing -> text htmlString
  
  parseHtmlElement :: forall n. String -> Maybe (Array (H.ComponentHTML Action Slots n))
  parseHtmlElement str = 
    Just $ parseHtmlElements str
  
  parseHtmlElements :: forall n. String -> Array (H.ComponentHTML Action Slots n)
  parseHtmlElements str = 
    parseNextElement str []
    where
      parseNextElement :: String -> Array (H.ComponentHTML Action Slots n) -> Array (H.ComponentHTML Action Slots n)
      parseNextElement content acc =
        case String.indexOf (String.Pattern "<") content of
          Nothing -> 
            -- No more tags, add remaining text if any
            if String.trim content == "" 
            then acc 
            else acc <> [text content]
          Just tagStart ->
            let beforeTag = String.take tagStart content
                afterTagStart = String.drop tagStart content
                accWithText = if String.trim beforeTag == "" 
                             then acc 
                             else acc <> [text beforeTag]
            in case parseTag afterTagStart of
              Just { element, remaining } ->
                parseNextElement remaining (accWithText <> [element])
              Nothing ->
                -- Could not parse tag, treat as text
                accWithText <> [text afterTagStart]
      
      parseTag :: String ->  Maybe { element :: H.ComponentHTML Action Slots n, remaining :: String }
      parseTag content =
        case String.indexOf (String.Pattern ">") content of
          Nothing -> Nothing -- Malformed tag
          Just closingBracket ->
            let tagContent = String.take (closingBracket + 1) content
                remaining = String.drop (closingBracket + 1) content
            in parseSpecificTag tagContent remaining
      
      parseSpecificTag :: String -> String -> Maybe { element :: H.ComponentHTML Action Slots n, remaining :: String }
      parseSpecificTag tagStr remaining =
        -- Parse <a href="...">...</a>
        if String.indexOf (String.Pattern "<a ") tagStr == Just 0 then
          parseAnchorTag tagStr remaining
        -- Parse <span>...</span>  
        else if String.indexOf (String.Pattern "<span") tagStr == Just 0 then
          parseSimpleTag "span" tagStr remaining (\children -> span_ children)
        -- Parse <strong>...</strong>
        else if String.indexOf (String.Pattern "<strong") tagStr == Just 0 then
          parseSimpleTag "strong" tagStr remaining (\children -> strong_ children)
        -- Parse <em>...</em>
        else if String.indexOf (String.Pattern "<em") tagStr == Just 0 then
          parseSimpleTag "em" tagStr remaining (\children -> em_ children)
        -- Parse <p>...</p>
        else if String.indexOf (String.Pattern "<p") tagStr == Just 0 then
          parseSimpleTag "p" tagStr remaining (\children -> p_ children)
        else 
          Nothing
      
      parseAnchorTag :: String -> String -> Maybe { element :: H.ComponentHTML Action Slots n, remaining :: String }
      parseAnchorTag tagStr remaining =
        case String.indexOf (String.Pattern "href=\"") tagStr of
          Nothing -> Nothing
          Just hrefStart ->
            case String.indexOf (String.Pattern "\"") (String.drop (hrefStart + 6) tagStr) of
              Nothing -> Nothing
              Just hrefEnd ->
                let hrefValue = String.take hrefEnd (String.drop (hrefStart + 6) tagStr)
                in case String.indexOf (String.Pattern "</a>") remaining of
                  Nothing -> Nothing
                  Just closeTagIdx ->
                    let linkText = String.take closeTagIdx remaining
                        afterCloseTag = String.drop (closeTagIdx + 4) remaining
                        linkElement = a [ href hrefValue, target "_blank" ] [ text linkText ]
                    in Just { element: linkElement, remaining: afterCloseTag }
      
      parseSimpleTag :: String -> String -> String -> (Array (H.ComponentHTML Action Slots n) -> H.ComponentHTML Action Slots n) -> Maybe { element :: H.ComponentHTML Action Slots n, remaining :: String }
      parseSimpleTag tagName _ remaining createElement =
        let closeTag = "</" <> tagName <> ">"
        in case String.indexOf (String.Pattern closeTag) remaining of
          Nothing -> Nothing
          Just closeTagIdx ->
            let innerContent = String.take closeTagIdx remaining
                afterCloseTag = String.drop (closeTagIdx + String.length closeTag) remaining
                innerElements = parseHtmlElements innerContent
                element = createElement innerElements
            in Just { element, remaining: afterCloseTag }

  lines =
    line _.role role
      <> line _.job job
      <> line _.phone phone
      <> line _.email email
