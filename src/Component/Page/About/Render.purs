module Component.Page.About.Render
  ( render
  )
  where

import Prelude hiding (div)

import Capability.AppM (AppM)
import Component.Page.About.Style.About (classId)
import Component.Page.About.Style.Card.Card as Card
import Component.Page.About.Style.Card.Line as CardLine
import Component.Page.About.Style.Card.Names as CardNames
import Component.Page.About.Style.Card.Portrait as CardPortrait
import Component.Page.About.Style.Sheet (sheet)
import Component.Page.About.Type (Action, Member, Slots, State, email, job, phone, role)
import Data.Maybe (Maybe, fromMaybe, maybe)
import Halogen (ComponentHTML)
import Halogen.HTML (HTML, div, img, text)
import Halogen.HTML.Properties (src)
import Html.Renderer.Halogen (render_)
import Util.File.Path (imageDirPath)
import Util.Style (class_, classes)

render :: State -> ComponentHTML Action Slots AppM
render state =
  div
    [ class_ classId ]
    ([ sheet ] <> (map renderMemberCard state.members))

loadingPlaceholder :: String
loadingPlaceholder = "__loading__"

renderMemberCard :: Maybe Member -> ComponentHTML Action Slots AppM
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
              <> if isLoading then [] else [ src $ imageDirPath <> "component/page/about/member/" <> member_.portraitId <> ".png" ]
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
    , originalPortraitUrl: loadingPlaceholder
    }
    member

  isLoading :: Boolean
  isLoading = maybe true (const false) member

  line :: forall w i. (Member -> String) -> String -> Array (HTML w i)
  line getter key =
    if not isLoading && getter member_ == "" then []
    else
      [ div
          [ classes [ CardLine.classId, CardLine.classIdWhen key ] ]
          [ render_ $ getter member_ ]
      ]

  lines :: forall w i. Array (HTML w i)
  lines =
    line _.role role
      <> line _.job job
      <> line _.phone phone
      <> line _.email email
