module Component.Page.About.Render
  ( render
  )
  where

import Proem hiding (div)

import Capability.AppM (AppM)
import Component.Common.PrettyErrorImage.Component as PrettyErrorImage
import Component.Common.Separator.Component as Separator
import Component.Page.About.HandleAction (ourImageRelativePath)
import Component.Page.About.Style.About (classId)
import Component.Page.About.Style.Card.Card as Card
import Component.Page.About.Style.Card.Line as CardLine
import Component.Page.About.Style.Card.Names as CardNames
import Component.Page.About.Style.Card.Portrait as CardPortrait
import Component.Page.About.Style.Collaborator as Collaborator
import Component.Page.About.Style.Collaborators as Collaborators
import Component.Page.About.Style.Members as Members
import Component.Page.About.Style.Sheet (sheet)
import Component.Page.About.Type (Action, Member, Slots, State, collaborators, email, job, members, phone, portraits, role, separators)
import Component.Util.Type (noOutputAction)
import Data.Array (length, mapWithIndex, replicate)
import Data.Maybe (Maybe(..), isNothing)
import Data.String (trim)
import Halogen (ComponentHTML)
import Halogen.HTML (HTML, div, slot, strong_, text)
import Html.Renderer.Halogen (render_)
import Util.Style (class_, classes)

render :: State -> ComponentHTML Action Slots AppM
render s =
  div
    [ class_ classId ]
    $ [ sheet
    , slot 
        separators 
        members 
        Separator.component 
        { text: "Bureau des membres de l'association" 
        , loading: isNothing s.members
        } 
        noOutputAction
    , div 
      [ class_ Members.classId ]
      $ mapWithIndex 
        (renderCard $ isNothing s.members) 
        (s.members ??⇒ replicate 6 loadingMember)
    ] <> (
      isNothing s.members ? [] ↔ [
        slot 
          separators 
          collaborators 
          Separator.component
          { text: "Collaborateurs du comité scientifique international" 
          , loading: isNothing s.collaborators
          } 
          noOutputAction
      ] <> (
        (length $ s.collaborators ??⇒ []) == 0 ? [
          text "Aucun collaborateur pour le moment."
        ] ↔ [
          div
            [ class_ Collaborators.classId ]
            $ (s.collaborators ??⇒ []) 
              <#> 
              (\c -> 
                div
                  [ class_ Collaborator.classId ]
                  [ strong_
                    [ text $ trim $ c.firstname <> " " <> c.lastname ]
                  , text $ c.country /= "" ? " (" <> c.country <> ")" ↔ ""
                  ]
              )
        ]
      )
    )

loadingPlaceholder :: String
loadingPlaceholder = "__loading__"

loadingMember :: Member
loadingMember = 
  { lastname: loadingPlaceholder
  , firstname: loadingPlaceholder
  , role: loadingPlaceholder
  , job: loadingPlaceholder
  , phone: loadingPlaceholder
  , email: loadingPlaceholder
  , portraitId: loadingPlaceholder
  }

renderCard :: Boolean -> Int -> Member -> ComponentHTML Action Slots AppM
renderCard isLoading idx member = 
  div
    [ classes $
      [ Card.classId ]
      <> (isLoading ? [ Card.classIdWhenLoading ] ↔ [ Card.classIdWhenLoaded ])
    ]
    ( [ div
        [ class_ CardNames.classId ]
        [ text $ isLoading ? loadingPlaceholder ↔ trim $ member.firstname <> " " <> member.lastname ]
      , slot 
        portraits
        (isLoading ? show idx ↔ member.firstname <> " " <> member.lastname)
        PrettyErrorImage.component
        { class_: Just CardPortrait.classId
        , src: isLoading ? Nothing ↔ (Just $ ourImageRelativePath member.portraitId)
        }
        noOutputAction
      ] <> lines
    )
  where
  line :: ∀ w i. (Member -> String) -> String -> Array (HTML w i)
  line getter key =
    not isLoading && getter member == "" 
    ? []
    ↔ [ div
      [ classes [ CardLine.classId, CardLine.classIdWhen key ] ]
      [ render_ $ getter member ]
    ]

  lines :: ∀ w i. Array (HTML w i)
  lines =
    line _.role role
      <> line _.job job
      <> line _.phone phone
      <> line _.email email
