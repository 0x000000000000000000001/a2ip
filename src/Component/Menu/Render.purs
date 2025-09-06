module Component.Menu.Render (render) where

import Prelude hiding (top, div)

import CSS (flexGrow, fromString, marginLeft, minWidth, opacity, rem, visibility)
import CSS.Common (hidden, visible)
import Component.Menu.Style (itemClassName, itemIconClassName, itemIconContainerClassName, logoClassName, menuClassName, stylesheet, unfoldWidth)
import Component.Menu.Type (Action(..), State)
import Halogen as H
import Halogen.HTML (HTML, div, img, nav, text)
import Halogen.HTML.CSS as HCSS
import Halogen.HTML.Events as HE
import Halogen.HTML.Properties as HP
import Utils.Style (class_)

newtype Item = Item { label :: String, iconFileName :: String, children :: Array Item }

items :: Array Item
items =
  [ Item { label: "Accueil", iconFileName: "home", children: [] }
  , Item { label: "Bureau et collaborateurs", iconFileName: "armchair", children: [] }
  , Item { label: "Adhésions", iconFileName: "writing", children: [] }
  , Item { label: "Séminaires", iconFileName: "micro", children: [] }
  , Item { label: "Colloques", iconFileName: "micro-2", children: [] }
  , Item { label: "Archives", iconFileName: "archive", children: [] }
  , Item { label: "Publications des membres", iconFileName: "book", children: [] }
  , Item { label: "Contact et mentions légales", iconFileName: "contact", children: [] }
  ]

render :: forall m. State -> H.ComponentHTML Action () m
render s =
  nav
    [ class_ menuClassName
    , HE.onMouseEnter $ const $ ToggleFolding true
    , HE.onMouseLeave $ const $ ToggleFolding false
    ]
    ( [ stylesheet s
      , img
          [ class_ logoClassName
          , HP.src "assets/images/logo.png"
          , HP.alt "Logo"
          ]
      ] <> (items <#> \(Item { label, iconFileName }) -> item label iconFileName)
    )
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
