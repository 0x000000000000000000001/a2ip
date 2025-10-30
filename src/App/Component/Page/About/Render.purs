module App.Component.Page.About.Render
  ( render
  ) where

import Proem hiding (div)

import App.Component.Common.PrettyErrorImage.Component as PrettyErrorImage
import App.Component.Common.Separator.Component as Separator
import App.Component.Common.Separator.Type (TextElementTag(..))
import App.Component.Page.About.Style.About (classId)
import App.Component.Page.About.Style.Card.Card as Card
import App.Component.Page.About.Style.Card.Line as CardLine
import App.Component.Page.About.Style.Card.Names as CardNames
import App.Component.Page.About.Style.Card.Portrait as CardPortrait
import App.Component.Page.About.Style.Collaborators as Collaborators
import App.Component.Page.About.Style.Members as Members
import App.Component.Page.About.Style.Sheet (sheet)
import App.Component.Page.About.Type (Action, Person, PersonRow, Slots, State, collaborators, country, email, job, members, phone, portraits, role, separators)
import App.Component.Page.Util.Image (ourImageRelativePath)
import App.Component.Util.Type (noOutputAction)
import App.Util.Capability.AppM (AppM)
import Data.Array (mapWithIndex, replicate)
import Data.Maybe (Maybe(..), isNothing)
import Data.String (trim)
import Data.Symbol (class IsSymbol)
import Halogen (ComponentHTML)
import Halogen.HTML (HTML, div, slot, text)
import Html.Renderer.Halogen (render_)
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
      , slot
          separators
          (ᴠ members)
          Separator.component
          { text: "Bureau des membres de l'association"
          , textElementTag: H1
          , loading: isNothing s.members
          }
          noOutputAction
      , div
          [ class_ Members.classId ]
          $ mapWithIndex
              (renderCard members $ isNothing s.members)
              (s.members ??⇒ replicate 6 loadingPerson)
      , slot
          separators
          (ᴠ collaborators)
          Separator.component
          { text: "Collaborateurs du comité scientifique international"
          , textElementTag: H2
          , loading: isNothing s.collaborators
          }
          noOutputAction
      , div
          [ class_ Collaborators.classId ]
          $ mapWithIndex
              (renderCard collaborators $ isNothing s.collaborators)
              (s.collaborators ??⇒ replicate 8 loadingPerson)
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
      , slot
          portraits
          ( (ᴠ section)
              <> (isLoading ? show idx ↔ member.firstname <> " " <> member.lastname)
          )
          PrettyErrorImage.component
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
          noOutputAction
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
    line role
      <> line job
      <> line phone
      <> line email
      <> line country
