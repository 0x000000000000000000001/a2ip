module App.Component.Router.Menu.Render (render) where

import Proem hiding (top, div)

import App.Component.Common.Link.Component (link)
import App.Component.Common.Link.Component as Link
import App.Component.Router.Menu.HandleLinkOutput (handleLinkOutput)
import App.Component.Router.Menu.Style.Item.Child (child_)
import App.Component.Router.Menu.Style.Item.Children (children_)
import App.Component.Router.Menu.Style.Item.Icon.Container (container_)
import App.Component.Router.Menu.Style.Item.Icon.Icon (icon)
import App.Component.Router.Menu.Style.Item.Item as Item
import App.Component.Router.Menu.Style.Item.Label (label_)
import App.Component.Router.Menu.Style.Logo (logo)
import App.Component.Router.Menu.Style.Menu (menu)
import App.Component.Router.Menu.Style.Sheet (sheet)
import App.Component.Router.Menu.Type (Action(..), State, Slots)
import App.Util.Capability.AppM (AppM)
import App.Util.Capability.Navigate (Route(..))
import CSS (flex, fromString)
import Data.Maybe (Maybe(..))
import Data.Tuple.Nested ((/\))
import Halogen (ComponentHTML)
import Halogen.HTML (slot, text)
import Halogen.HTML.Events (onMouseLeave, onMouseOver)
import Halogen.HTML.Properties (alt, src)
import Util.Proxy.Dictionary.Items (items')

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
render s@{ id, animating, unfold } =
  menu id
    ( animating 
        ? []
        ↔ [ 
          unfold
            ? (onMouseLeave $ κ $ ToggleFolding true)
            ↔ (onMouseOver $ κ $ ToggleFolding false)
        ]
    )
    ( [ sheet s
      , logo
          [ src "asset/image/logo.png"
          , alt "Logo"
          ]
      ] <> (items <#> \(ParentItem { label, route, iconFileName, children }) -> item label route iconFileName children)
    )
  where
  item :: String -> Maybe Route -> String -> Array ChildItem -> ComponentHTML Action Slots AppM
  item label' route iconFileName children =
    link
      items'
      (label' /\ route)
      { route
      , classes: Just [ Item.staticClass, Item.class' id ]
      , display: flex
      , children: 
        [ container_ id
            [ icon
              [ src (fromString "asset/image/component/router/menu/" <> iconFileName <> ".png")
              ]
            ]
        , label_ id
            [ text label' ]
        , children_
            (children <#> \(ChildItem { label }) -> child_ [ text label ])
        ]
      }
      handleLinkOutput
