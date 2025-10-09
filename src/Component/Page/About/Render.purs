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
import Data.Array as Array
import Data.Maybe (Maybe, fromMaybe, maybe)
import Data.Tuple (Tuple(..))
import Halogen (ComponentHTML)
import Halogen.HTML (HTML, div, img, slot, text)
import Halogen.HTML.Properties (src)
import Html.Renderer.Halogen (render_)
import Type.Proxy (Proxy(..))
import Util.Log (unsafeDebugShow)
import Util.Style (class_, classes)

render :: State -> ComponentHTML Action Slots AppM
render state =
  div
    [ class_ classId ]
    ([ sheet ] <> (mapWithIndex renderMemberCard state.members))
  where
  mapWithIndex :: forall a b. (Int -> a -> b) -> Array a -> Array b
  mapWithIndex f arr = map (\(Tuple idx item) -> f idx item) (mapWithIndex' arr)
  
  mapWithIndex' :: forall a. Array a -> Array (Tuple Int a)
  mapWithIndex' = Array.mapWithIndex Tuple

loadingPlaceholder :: String
loadingPlaceholder = "__loading__"

renderMemberCard :: Int -> Maybe Member -> ComponentHTML Action Slots AppM
renderMemberCard idx member = 
  div
    [ classes $
        [ Card.classId ]
          <> if isLoading then [ Card.classIdWhenLoading ] else [ Card.classIdWhenLoaded ]
    ]
    ( [ div
          [ class_ CardNames.classId ]
          [ text $ maybe loadingPlaceholder (\m -> m.firstname <> " " <> m.lastname) member ]
      , slot 
          (Proxy :: Proxy "prettyErrorImage") 
          idx 
          PrettyErrorImage.component
          { iProps: 
              [ class_ CardPortrait.classId ]
              <> (if isLoading then [] else [ src member_.finalPortraitUrl ])
          }
          noOutputAction 
      , img (
        [ class_ CardPortrait.classId ]
        <> (if isLoading then [] else [ src member_.finalPortraitUrl ])
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
    , finalPortraitUrl: loadingPlaceholder
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
