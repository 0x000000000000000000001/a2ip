module Component.Router.Render where

import Prelude hiding (div)

import CSS (backgroundColor, borderRadius, display, flex, flexDirection, flexGrow, fromInt, marginLeft, minHeight, pct, rem, row, vh, width)
import Capability.Log (class Log)
import Capability.Navigate (class Navigate)
import Component.Router.Menu.Component as MenuComponent
import Component.Router.Menu.Style.Menu as MenuStyle
import Component.Router.Route (Route(..))
import Component.Router.Type (Action, State, Slots)
import Effect.Aff.Class (class MonadAff)
import Halogen as H
import Halogen.HTML (div, div_, slot, text)
import Halogen.HTML.CSS (style)
import Type.Proxy (Proxy(..))
import Utils.Style (margin, padding)

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
            marginLeft (rem MenuStyle.foldWidth)
            flexGrow 1.0
            display flex
        ]
        [ div
            [ style do
                backgroundColor (fromInt 0xffffff)
                padding 1.0
                width (pct 100.0)
                margin 2.0
                borderRadius (rem 0.6) (rem 0.6) (rem 0.6) (rem 0.6)
            ]
            [ div []
                [ text $ "🔄 Current route: " <> show route
                , div_
                    [ case route of
                        Home -> div [] [ text "🏠 Page d'accueil" ]
                        About -> div [] [ text "ℹ️ À propos" ]
                    ]
                ]
            ]
        ]
    ]
