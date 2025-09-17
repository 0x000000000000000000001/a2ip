module Component.Router.Render where

import Prelude hiding (div)

import CSS (backgroundColor, borderRadius, display, flex, flexDirection, flexGrow, fromInt, margin, minHeight, rem, row, vh)
import CSS.Overflow (overflow)
import CSS.Overflow as Overflow
import Capability.Log (class Log)
import Capability.Navigate (class Navigate)
import Component.Page.About.Component as PageAboutComponent
import Component.Router.Menu.Component as MenuComponent
import Component.Router.Menu.Style.Menu as MenuStyle
import Component.Router.Route (Route(..))
import Component.Router.Type (Action, State, Slots)
import Effect.Aff.Class (class MonadAff)
import Halogen as H
import Halogen.HTML (div, slot, text)
import Halogen.HTML.CSS (style)
import Type.Proxy (Proxy(..))
import Utils.Style (padding)

render :: forall m. MonadAff m => Navigate m => Log m => State -> H.ComponentHTML Action Slots m
render { route } =
  div
    [ style do
        display flex
        flexDirection row
        minHeight (vh 100.0)
    ]
    [ slot (Proxy :: Proxy "menu") unit MenuComponent.component unit absurd
    , div
        [ style do
            margin (rem 2.0) (rem 2.0) (rem 2.0) (rem $ 2.0 + MenuStyle.foldWidth)
            display flex
            backgroundColor (fromInt 0xffffff)
            padding 1.0
            borderRadius (rem 0.6) (rem 0.6) (rem 0.6) (rem 0.6)
            overflow Overflow.hidden
            flexGrow 1.0
        ]
        [ case route of
            Home -> div [] [ text "🏠 Page d'accueil" ]
            About -> slot (Proxy :: Proxy "about") unit PageAboutComponent.component unit absurd
        ]
    ]
