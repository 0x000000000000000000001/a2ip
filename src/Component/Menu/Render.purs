module Component.Menu.Render (render) where

import Prelude hiding (top, div)

import CSS (fromString)
import Component.Menu.Style.Item.Child as Child
import Component.Menu.Style.Item.Children as Children
import Component.Menu.Style.Item.Icon.Container as ItemIconContainer
import Component.Menu.Style.Item.Icon.Icon as ItemIcon
import Component.Menu.Style.Item.Item as Item
import Component.Menu.Style.Item.Label as Label
import Component.Menu.Style.Logo as Logo
import Component.Menu.Style.Menu (classId)
import Component.Menu.Style.Sheet (sheet)
import Component.Menu.Type (Action(..), State)
import Halogen as H
import Halogen.HTML (HTML, div, img, nav, text)
import Halogen.HTML.Events as HE
import Halogen.HTML.Properties as HP
import Utils.Style (class_)

type Item r =
  ( label :: String
  | r
  )

newtype ParentItem = ParentItem { | Item (iconFileName :: String, children :: Array ChildItem) }
newtype ChildItem = ChildItem { | Item () }

items :: Array ParentItem
items =
  [ ParentItem { label: "Accueil", iconFileName: "home", children: [] }
  , ParentItem { label: "Bureau et collaborateurs", iconFileName: "armchair", children: [] }
  , ParentItem { label: "Adhésions", iconFileName: "writing", children: [] }
  , ParentItem
      { label: "Séminaires"
      , iconFileName: "micro"
      , children:
          [ ChildItem { label: "Malaise dans la civilisation aujourd'hui" }
          , ChildItem { label: "Écrire l'histoire de la psychanalyse" }
          , ChildItem { label: "Politique et religion" }
          ]
      }
  , ParentItem { label: "Colloques", iconFileName: "micro-2", children: [] }
  , ParentItem { label: "Archives", iconFileName: "archive", children: [] }
  , ParentItem { label: "Publications des membres", iconFileName: "book", children: [] }
  , ParentItem { label: "Contact et mentions légales", iconFileName: "contact", children: [] }
  ]

render :: forall m. State -> H.ComponentHTML Action () m
render s =
  nav
    [ class_ classId
    , HE.onMouseEnter $ const $ ToggleFolding true
    , HE.onMouseLeave $ const $ ToggleFolding false
    ]
    ( [ sheet s
      , img
          [ class_ Logo.classId
          , HP.src "assets/images/logo.png"
          , HP.alt "Logo"
          ]
      ] <> (items <#> \(ParentItem { label, iconFileName, children }) -> item label iconFileName children)
    )
  where
  item :: forall w i. String -> String -> Array ChildItem -> HTML w i
  item label' iconFileName children =
    div [ class_ Item.classId ]
      [ div
          [ class_ $ ItemIconContainer.classId ]
          [ img
              [ class_ ItemIcon.classId
              , HP.src (fromString "assets/images/component/menu/" <> iconFileName <> ".png")
              ]
          ]
      , div
          [ class_ Label.classId ]
          [ text label' ]
      , div 
      [ class_ Children.classId ]
          (children <#> \(ChildItem { label }) -> div [ class_ Child.classId ] [ text label ])
      ]
