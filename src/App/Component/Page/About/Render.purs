module App.Component.Page.About.Render
  ( render
  ) where

import Proem hiding (div)

import App.Component.Common.PrettyErrorImage.Component (prettyErrorImage)
import App.Component.Common.Separator.Component (separator)
import App.Component.Common.Separator.Type (TextElementTag(..))
import App.Component.Page.About.Style.About (classId)
import App.Component.Page.About.Style.Card.Card as Card
import App.Component.Page.About.Style.Card.Line as CardLine
import App.Component.Page.About.Style.Card.Names as CardNames
import App.Component.Page.About.Style.Card.Portrait as CardPortrait
import App.Component.Page.About.Style.Collaborators as Collaborators
import App.Component.Page.About.Style.Members as Members
import App.Component.Page.About.Style.Sheet (sheet)
import App.Component.Page.About.Type (Action, Person, PersonRow, Slots, State, _collaborators, _country, _email, _job, _members, _phone, _portraits, _role, _separators)
import App.Component.Page.Util.Image (ourImageRelativePath)
import App.Util.Capability.AppM (AppM)
import Data.Array (mapWithIndex, replicate)
import Data.Maybe (Maybe(..))
import Data.String (trim)
import Data.Symbol (class IsSymbol)
import Halogen (ComponentHTML)
import Halogen.HTML (HTML, div, text)
import Html.Renderer.Halogen (render_)
import Network.RemoteData (isSuccess, toMaybe)
import Prim.Row (class Cons)
import Record (get)
import Type.Prelude (Proxy)
import Util.String (slugify)
import Util.Style (class_, classes)

render :: State -> ComponentHTML Action Slots AppM
render s =
  div
    [ class_ classId ]
    $
      [ sheet
      , separator 
          _separators 
          (ᴠ _members)
          { text: "Bureau des membres de l'association"
          , textElementTag: H1
          , loading: not $ isSuccess s.members
          }
      , div
          [ class_ Members.classId ]
          $ mapWithIndex
              (renderCard _members $ not $ isSuccess s.members)
              (toMaybe s.members ??⇒ replicate 6 loadingPerson)
      , separator
          _separators
          (ᴠ _collaborators)
          { text: "Membres du comité scientifique international"
          , textElementTag: H1
          , loading: not $ isSuccess s.collaborators
          }
      , div
          [ class_ Collaborators.classId ]
          $ mapWithIndex
              (renderCard _collaborators $ not $ isSuccess s.collaborators)
              (toMaybe s.collaborators ??⇒ replicate 8 loadingPerson)
      ]

loadingPlaceholder :: String
loadingPlaceholder = "__loading__"

loadingPerson :: Person
loadingPerson =
  { lastname: loadingPlaceholder
  , firstname: loadingPlaceholder
  , role: loadingPlaceholder
  , job: loadingPlaceholder
  , phone: loadingPlaceholder
  , email: loadingPlaceholder
  , country: loadingPlaceholder
  , portraitId: loadingPlaceholder
  }

renderCard :: ∀ sym. IsSymbol sym => Proxy sym -> Boolean -> Int -> Person -> ComponentHTML Action Slots AppM
renderCard section isLoading idx member =
  div
    [ classes
        $ [ Card.classId ]
        <> (isLoading ? [ Card.classIdWhenLoading ] ↔ [ Card.classIdWhenLoaded ])
    ]
    ( [ div
          [ class_ CardNames.classId ]
          [ text $ isLoading ? loadingPlaceholder ↔ trim $ member.firstname <> " " <> member.lastname ]
      , prettyErrorImage
          _portraits
          ( (ᴠ section)
              <> (isLoading ? show idx ↔ member.firstname <> " " <> member.lastname)
          )
          { class_: Just CardPortrait.classId
          , loading: isLoading
          , sources: 
              { first: 
                  ourImageRelativePath
                    ( member.portraitId == ""
                        ? (slugify $ member.firstname <> "-" <> member.lastname)
                        ↔ member.portraitId
                    )
              , fallback: 
                  Just $ ourImageRelativePath
                    ( member.portraitId /= ""
                        ? (slugify $ member.firstname <> "-" <> member.lastname)
                        ↔ "anonymous"
                    )
              }
          }
      ] <> lines
    )
  where
  line :: ∀ w i s row. IsSymbol s => Cons s String row PersonRow => Proxy s -> Array (HTML w i)
  line key =
    not isLoading && get key member == ""
      ? []
      ↔
        [ div
            [ classes [ CardLine.classId, CardLine.classIdWhen $ ᴠ key ] ]
            [ render_ $ get key member ]
        ]

  lines :: ∀ w i. Array (HTML w i)
  lines =
    line _role
      <> line _job
      <> line _phone
      <> line _email
      <> line _country
