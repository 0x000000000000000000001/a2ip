module App.Component.Page.About.Render
  ( render
  ) where

import Proem hiding (div)

import App.Component.Common.PrettyErrorImage.Component (prettyErrorImage)
import App.Component.Common.PrettyErrorImage.Type (defaultInput)
import App.Component.Common.Separator.Component (separator)
import App.Component.Common.Separator.Type (TextElementTag(..))
import App.Component.Page.About.Style.About (staticClass)
import App.Component.Page.About.Style.Card.Card as Card
import App.Component.Page.About.Style.Card.Line (line_)
import App.Component.Page.About.Style.Card.Names as Names
import App.Component.Page.About.Style.Card.Portrait as Portrait
import App.Component.Page.About.Style.Collaborators as Collaborators
import App.Component.Page.About.Style.Members as Members
import App.Component.Page.About.Style.Sheet (sheet)
import App.Component.Page.About.Type (Action, Person, PersonRow, Slots, State)
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
import Util.Proxy.Dictionary.Collaborators (collaborators', collaborators_)
import Util.Proxy.Dictionary.Country (country')
import Util.Proxy.Dictionary.Email (email')
import Util.Proxy.Dictionary.Job (job')
import Util.Proxy.Dictionary.Members (members', members_)
import Util.Proxy.Dictionary.Phone (phone')
import Util.Proxy.Dictionary.Portraits (portraits')
import Util.Proxy.Dictionary.Role (role')
import Util.Proxy.Dictionary.Separators (separators')
import Util.String (slugify)
import Util.Style.Style (class_, classes)

render :: State -> ComponentHTML Action Slots AppM
render s =
  div
    [ class_ staticClass ]
    $
      [ sheet
      , separator 
          separators' 
          members_
          { text: "Bureau des membres de l'association"
          , textElementTag: H1
          , loading: not $ isSuccess s.members
          }
      , div
          [ class_ Members.staticClass ]
          $ mapWithIndex
              (renderCard members' $ not $ isSuccess s.members)
              (toMaybe s.members ??⇒ replicate 6 loadingPerson)
      , separator
          separators'
          collaborators_
          { text: "Membres du comité scientifique international"
          , textElementTag: H1
          , loading: not $ isSuccess s.collaborators
          }
      , div
          [ class_ Collaborators.staticClass ]
          $ mapWithIndex
              (renderCard collaborators' $ not $ isSuccess s.collaborators)
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
        $ [ Card.staticClass ]
        <> (isLoading ? [ Card.staticClassWhenLoading ] ↔ [ Card.staticClassWhenLoaded ])
    ]
    ( [ div
          [ class_ Names.staticClass ]
          [ text $ isLoading ? loadingPlaceholder ↔ trim $ member.firstname <> " " <> member.lastname ]
      , div 
          [ class_ Portrait.staticClass ]
          [ prettyErrorImage
              portraits'
              ( (ᴠ section)
                  <> (isLoading ? show idx ↔ member.firstname <> " " <> member.lastname)
              )
              defaultInput 
                { loading = isLoading
                , sources =
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
                , style = Portrait.prettyErrorImageStyle
                }
          ]
      ] <> lines
    )
  where
  line :: ∀ w i s row. IsSymbol s => Cons s String row PersonRow => Proxy s -> Array (HTML w i)
  line key =
    not isLoading && get key member == ""
      ? []
      ↔ [ line_ key
            [ render_ $ get key member ]
        ]

  lines :: ∀ w i. Array (HTML w i)
  lines =
    line role'
      <> line job'
      <> line phone'
      <> line email'
      <> line country'
