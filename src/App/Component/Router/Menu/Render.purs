module App.Component.Router.Menu.Render (render) where

import Proem hiding (top, div)

import App.Component.Common.Link.Component as Link
import App.Component.Router.Menu.HandleLinkOutput (handleLinkOutput)
import App.Component.Router.Menu.Style.Item.Child as Child
import App.Component.Router.Menu.Style.Item.Children as Children
import App.Component.Router.Menu.Style.Item.Icon.Container as ItemIconContainer
import App.Component.Router.Menu.Style.Item.Icon.Icon as ItemIcon
import App.Component.Router.Menu.Style.Item.Item as Item
import App.Component.Router.Menu.Style.Item.Label as Label
import App.Component.Router.Menu.Style.Logo as Logo
import App.Component.Router.Menu.Style.Menu (classId)
import App.Component.Router.Menu.Style.Sheet (sheet)
import App.Component.Router.Menu.Type (Action(..), State, Slots)
import App.Component.Router.Menu.Type as Type
import App.Util.Capability.AppM (AppM)
import App.Util.Capability.Navigate (Route(..))
import CSS (flex, fromString)
import Data.Maybe (Maybe(..))
import Data.Tuple.Nested ((/\))
import Halogen (ComponentHTML)
import Halogen.HTML (div, img, nav, slot, text)
import Halogen.HTML.Events (onMouseLeave, onMouseOver)
import Halogen.HTML.Properties (alt, src)
import Halogen.HTML.Properties as HP
import Util.Style (class_)

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
      , route: Just Seminars
      , iconFileName: "micro"
      , children:
          [ ChildItem { label: "Malaise dans la civilisation aujourd'hui", route: Nothing }
          , ChildItem { label: "Écrire l'histoire de la psychanalyse", route: Nothing }
          , ChildItem { label: "Politique et religion", route: Nothing }
          ]
      }
  , ParentItem { label: "Colloques", route: Nothing, iconFileName: "micro-2", children: [] }
  , ParentItem { label: "Conférences", route: Nothing, iconFileName: "presentation-1", children: [] }
  , ParentItem { label: "Archives", route: Nothing, iconFileName: "archive", children: [] }
  , ParentItem { label: "Publications des membres", route: Nothing, iconFileName: "book", children: [] }
  , ParentItem { label: "Contact et mentions légales", route: Nothing, iconFileName: "contact", children: [] }
  ]

render :: State -> ComponentHTML Action Slots AppM
render s =
  nav
    ( [ class_ classId
      , HP.id "menu"
      ] 
      <> (
        s.animating 
          ? []
          ↔ [ 
            s.unfold
              ? (onMouseLeave $ κ $ ToggleFolding true)
              ↔ (onMouseOver $ κ $ ToggleFolding false)
          ]
      )
    )
    ( [ sheet s
      , img
          [ class_ Logo.classId
          , src "asset/image/logo.png"
          , alt "Logo"
          ]
      ] <> (items <#> \(ParentItem { label, route, iconFileName, children }) -> item label route iconFileName children)
    )
  where
  item :: String -> Maybe Route -> String -> Array ChildItem -> ComponentHTML Action Slots AppM
  item label' route iconFileName children =
    slot Type.items (label' /\ route) Link.component
      { route
      , class_: Just Item.classId
      , display: flex
      , children: 
        [ div
          [ class_ $ ItemIconContainer.classId ]
          [ img
            [ class_ ItemIcon.classId
            , src (fromString "asset/image/component/router/menu/" <> iconFileName <> ".png")
            ]
          ]
        , div
          [ class_ Label.classId ]
          [ text label' ]
        , div
          [ class_ Children.classId ]
          (children <#> \(ChildItem { label }) -> div [ class_ Child.classId ] [ text label ])
        ]
      }
      handleLinkOutput
