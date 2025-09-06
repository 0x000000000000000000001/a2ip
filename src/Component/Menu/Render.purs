module Component.Menu.Render (render) where

import Prelude hiding (top, div)

import CSS (Selector, alignItems, alignSelf, backgroundColor, borderRadius, borderRight, boxShadow, color, column, cursor, display, fixed, flex, flexDirection, flexGrow, flexStart, fromString, graytone, height, hover, justifyContent, key, left, margin, marginLeft, minWidth, opacity, padding, position, rem, rgba, solid, top, vh, visibility, white, width, zIndex, (&), (?), (|*))
import CSS as CSS
import CSS.Box (bsColor, shadow)
import CSS.Common (center, visible, hidden)
import CSS.Cursor (pointer)
import CSS.Overflow (overflow)
import CSS.Overflow as Overflow
import Data.NonEmpty (singleton)
import Effect.Aff.Class (class MonadAff)
import Halogen as H
import Halogen.HTML (HTML, div, img, nav, text)
import Halogen.HTML.CSS as HCSS
import Halogen.HTML.Events as HE
import Halogen.HTML.Properties as HP
import Utils (class_, ourRed)

render :: forall m. State -> H.ComponentHTML Action () m
render s =
  nav
    [ class_ menuClassName
    , HE.onMouseEnter \_ -> ToggleFolding true
    , HE.onMouseLeave \_ -> ToggleFolding false
    ]
    [ stylesheet s
    , img
        [ class_ logoClassName
        , HP.src "assets/images/logo.png"
        , HP.alt "Logo"
        ]
    , item "Accueil" "home"
    , item "Bureau et collaborateurs" "armchair"
    , item "Adhésions" "writing"
    , item "Séminaires" "micro"
    , item "Colloques" "micro-2"
    , item "Archives" "archive"
    , item "Publications des membres" "book"
    , item "Contact et mentions légales" "contact"
    ]
  where
  item :: forall w i. String -> String -> HTML w i
  item label iconFileName =
    div [ class_ itemClassName ]
      [ div
          [ class_ $ itemIconContainerClassName
          ]
          [ img
              [ class_ itemIconClassName
              , HP.src (fromString "assets/images/component/menu/" <> iconFileName <> ".png")
              , HP.alt label
              ]
          ]
      , div
          [ HCSS.style do
              visibility if s.isUnfold then visible else hidden
              opacity (if s.isUnfold then 1.0 else 0.0)
              flexGrow 1.0
              minWidth (rem unfoldWidth)
              marginLeft (rem 1.4)
          ]
          [ text label ]
      ]
