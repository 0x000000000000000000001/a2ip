module Component.Router.Menu.Render (render) where

import Prelude hiding (top, div)

import AppM (AppM)
import CSS (fromString)
import Component.Router.Menu.Style.Item.Child as Child
import Component.Router.Menu.Style.Item.Children as Children
import Component.Router.Menu.Style.Item.Icon.Container as ItemIconContainer
import Component.Router.Menu.Style.Item.Icon.Icon as ItemIcon
import Component.Router.Menu.Style.Item.Item as Item
import Component.Router.Menu.Style.Item.Label as Label
import Component.Router.Menu.Style.Logo as Logo
import Component.Router.Menu.Style.Menu (classId)
import Component.Router.Menu.Style.Sheet (sheet)
import Component.Router.Menu.Type (Action(..), State)
import Component.Router.Route (Route(..))
import Data.Maybe (Maybe(..))
import Halogen as H
import Halogen.HTML (HTML, div, img, nav, text)
import Halogen.HTML.Events as HE
import Halogen.HTML.Properties as HP
import Utils.Style (class_)

type Item r =
  ( label :: String
  , route :: Maybe Route
  | r
  )

newtype ParentItem = ParentItem { | Item (iconFileName :: String, children :: Array ChildItem) }
newtype ChildItem = ChildItem { | Item () }

items :: Array ParentItem
items =
  [ ParentItem { label: "Accueil", route: Just Home, iconFileName: "home", children: [] }
  , ParentItem { label: "Bureau et collaborateurs", route: Just About, iconFileName: "armchair", children: [] }
  , ParentItem { label: "Adhésions", route: Nothing, iconFileName: "writing", children: [] }
  , ParentItem
      { label: "Séminaires"
      , route: Nothing
      , iconFileName: "micro"
      , children:
          [ ChildItem { label: "Malaise dans la civilisation aujourd'hui", route: Nothing }
          , ChildItem { label: "Écrire l'histoire de la psychanalyse", route: Nothing }
          , ChildItem { label: "Politique et religion", route: Nothing }
          ]
      }
  , ParentItem { label: "Colloques", route: Nothing, iconFileName: "micro-2", children: [] }
  , ParentItem { label: "Archives", route: Nothing, iconFileName: "archive", children: [] }
  , ParentItem { label: "Publications des membres", route: Nothing, iconFileName: "book", children: [] }
  , ParentItem { label: "Contact et mentions légales", route: Nothing, iconFileName: "contact", children: [] }
  ]

render :: State -> H.ComponentHTML Action () AppM
render s =
  nav
    [ class_ classId
    , if s.isUnfold then HE.onMouseLeave $ const $ ToggleFolding true
      else HE.onMouseEnter $ const $ ToggleFolding false
    ]
    ( [ sheet s
      , img
          [ class_ Logo.classId
          , HP.src "asset/image/logo.png"
          , HP.alt "Logo"
          ]
      ] <> (items <#> \(ParentItem { label, route, iconFileName, children }) -> item label route iconFileName children)
    )
  where
  item :: forall w. String -> Maybe Route -> String -> Array ChildItem -> HTML w Action
  item label' route iconFileName children =
    div
      ( [ class_ Item.classId ] <>
          ( case route of
              Just route_ -> [ HE.onClick $ const $ Navigate route_ ]
              Nothing -> []
          )
      )
      [ div
          [ class_ $ ItemIconContainer.classId ]
          [ img
              [ class_ ItemIcon.classId
              , HP.src (fromString "asset/image/component/menu/" <> iconFileName <> ".png")
              ]
          ]
      , div
          [ class_ Label.classId ]
          [ text label' ]
      , div
          [ class_ Children.classId ]
          (children <#> \(ChildItem { label }) -> div [ class_ Child.classId ] [ text label ])
      ]
