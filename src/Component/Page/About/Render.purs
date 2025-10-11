module Component.Page.About.Render
  ( render
  )
  where

import Prelude hiding (div)

import Capability.AppM (AppM)
import Component.Common.PrettyErrorImage.Component as PrettyErrorImage
import Component.Page.About.Style.About (classId)
import Component.Page.About.Style.Card.Card as Card
import Component.Page.About.Style.Card.Line as CardLine
import Component.Page.About.Style.Card.Names as CardNames
import Component.Page.About.Style.Card.Portrait as CardPortrait
import Component.Page.About.Style.Sheet (sheet)
import Component.Page.About.Type (Action, Member, Slots, State, email, job, phone, role)
import Component.Util.Type (noOutputAction)
import Data.Array (mapWithIndex)
import Data.Maybe (Maybe(..), isNothing)
import Halogen (ComponentHTML)
import Halogen.HTML (HTML, div, slot, text)
import Html.Renderer.Halogen (render_)
import Type.Proxy (Proxy(..))
import Util.Condition ((?), (↔))
import Util.Maybe ((??), (??⇒), (⇔))
import Util.Style (class_, classes)

render :: State -> ComponentHTML Action Slots AppM
render state =
  div
    [ class_ classId ]
    ([ sheet ] <> (mapWithIndex renderMemberCard state.members))
  
loadingPlaceholder :: String
loadingPlaceholder = "__loading__"

renderMemberCard :: Int -> Maybe Member -> ComponentHTML Action Slots AppM
renderMemberCard idx member = 
  div
    [ classes $
        [ Card.classId ]
        <> (isLoading ? [ Card.classIdWhenLoading ] ↔ [ Card.classIdWhenLoaded ])
    ]
    ( [ div
          [ class_ CardNames.classId ]
          [ text $ member ?? (\m -> m.firstname <> " " <> m.lastname) ⇔ loadingPlaceholder ]
      , slot 
          (Proxy :: Proxy "prettyErrorImage") 
          (member ?? (\m -> m.firstname <> " " <> m.lastname) ⇔ show idx)
          PrettyErrorImage.component
          { class_: Just CardPortrait.classId
          , src: isLoading ? Nothing ↔ Just member_.finalPortraitUrl
          }
          noOutputAction
      ] <> lines
    )
  where
  isLoading :: Boolean
  isLoading = isNothing member

  member_ :: Member
  member_ = member ??⇒
    { lastname: loadingPlaceholder
    , firstname: loadingPlaceholder
    , role: loadingPlaceholder
    , job: loadingPlaceholder
    , phone: loadingPlaceholder
    , email: loadingPlaceholder
    , portraitId: loadingPlaceholder
    , originalPortraitUrl: loadingPlaceholder
    , finalPortraitUrl: loadingPlaceholder
    }

  line :: forall w i. (Member -> String) -> String -> Array (HTML w i)
  line getter key =
    not isLoading && getter member_ == "" 
    ? []
    ↔ [ div
      [ classes [ CardLine.classId, CardLine.classIdWhen key ] ]
      [ render_ $ getter member_ ]
    ]

  lines :: forall w i. Array (HTML w i)
  lines =
    line _.role role
      <> line _.job job
      <> line _.phone phone
      <> line _.email email
