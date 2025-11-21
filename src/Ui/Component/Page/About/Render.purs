module Ui.Component.Page.About.Render
  ( render
  ) where

import Proem hiding (div)

import Ui.Component.Common.PrettyErrorImage.Component (prettyErrorImage)
import Ui.Component.Common.PrettyErrorImage.Type (defaultInput)
import Ui.Component.Common.Separator.Component (separator)
import Ui.Component.Common.Separator.Type (TextElementTag(..))
import Ui.Component.Page.About.Style.About (about_)
import Ui.Component.Page.About.Style.Card.Card (card_)
import Ui.Component.Page.About.Style.Card.Line (line_)
import Ui.Component.Page.About.Style.Card.Names (names_)
import Ui.Component.Page.About.Style.Card.Portrait (portrait_)
import Ui.Component.Page.About.Style.Card.Portrait as Portrait
import Ui.Component.Page.About.Style.Collaborators (collaborators_)
import Ui.Component.Page.About.Style.Members (members_)
import Ui.Component.Page.About.Style.Sheet (sheet)
import Ui.Component.Page.About.Type (Action, Person, PersonRow, Slots, State)
import Ui.Component.Page.Util.Image (ourImageRelativePath)
import Ui.Util.Capability.AppM (AppM)
import Data.Array (mapWithIndex, replicate)
import Data.Maybe (Maybe(..))
import Data.String (trim)
import Data.Symbol (class IsSymbol)
import Halogen (ComponentHTML)
import Halogen.HTML (HTML, text)
import Html.Renderer.Halogen (render_)
import Network.RemoteData (isSuccess, toMaybe)
import Prim.Row (class Cons)
import Record (get)
import Type.Prelude (Proxy)
import Util.Proxy.Dictionary.Collaborators (collaborators')
import Util.Proxy.Dictionary.Country (country')
import Util.Proxy.Dictionary.Email (email')
import Util.Proxy.Dictionary.Job (job')
import Util.Proxy.Dictionary.Members (members')
import Util.Proxy.Dictionary.Phone (phone')
import Util.Proxy.Dictionary.Portraits (portraits')
import Util.Proxy.Dictionary.Role (role')
import Util.Proxy.Dictionary.Separators (separators')
import Util.String (slugify)

render :: State -> ComponentHTML Action Slots AppM
render s =
  about_
    [ sheet
    , separator 
        separators' 
        (ᴠ members')
        { text: "Bureau des membres de l'association"
        , textElementTag: H1
        , loading: not $ isSuccess s.members
        }
    , members_
        $ mapWithIndex
            (renderCard members' $ not $ isSuccess s.members)
            (toMaybe s.members ??⇒ replicate 6 loadingPerson)
    , separator
        separators'
        (ᴠ collaborators')
        { text: "Membres du comité scientifique international"
        , textElementTag: H1
        , loading: not $ isSuccess s.collaborators
        }
    , collaborators_
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
  card_ isLoading
    ( [ names_
          [ text $ isLoading ? loadingPlaceholder ↔ trim $ member.firstname <> " " <> member.lastname ]
      , portrait_
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
