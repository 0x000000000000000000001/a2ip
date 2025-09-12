module Main (main) where

import Prelude hiding (div)

import CSS (StyleM, backgroundColor, borderRadius, display, flex, flexDirection, flexGrow, fromInt, margin, marginLeft, minHeight, padding, pct, rem, row, vh, width)
import Capability.Log (class Log)
import Capability.Navigate (class Navigate)
import Component.Menu.Component as MenuComponent
import Component.Menu.Style.Menu as MenuStyle
import Data.Const (Const)
import Effect (Effect)
import Effect.Aff (launchAff_)
import Effect.Aff.Class (class MonadAff)
import Halogen as H
import Halogen.Aff (awaitBody)
import Halogen.HTML (div, slot, text)
import Halogen.HTML.CSS (style)
import Halogen.VDom.Driver (runUI)
import Type.Proxy (Proxy(..))
import AppM (runAppM)

type Slots = ( menu :: H.Slot (Const Void) Void Unit )

type AppState = Unit

data AppAction = AppAction

mainLayoutStyles :: StyleM Unit
mainLayoutStyles = do
  display flex
  flexDirection row
  minHeight (vh 100.0)

component :: forall q o m. MonadAff m => Navigate m => Log m => H.Component q Unit o m
component = H.mkComponent
  { initialState: \_ -> unit
  , render
  , eval: H.mkEval H.defaultEval { handleAction = handleAction }
  }

handleAction :: forall o m. MonadAff m => AppAction -> H.HalogenM AppState AppAction Slots o m Unit
handleAction = case _ of
  AppAction -> pure unit

render :: forall m. MonadAff m => Navigate m => Log m => AppState -> H.ComponentHTML AppAction Slots m
render _ =
  div
    [ style mainLayoutStyles ]
    [ slot (Proxy :: Proxy "menu") unit MenuComponent.component unit (const AppAction)
    , div [ style do
        marginLeft (rem MenuStyle.foldWidth)
        flexGrow 1.0
        display flex
      ]
      [ div [ style do
          backgroundColor (fromInt 0xffffff)
          padding (rem 1.0) (rem 1.0) (rem 1.0) (rem 1.0)
          width (pct 100.0)
          margin (rem 2.0) (rem 2.0) (rem 2.0) (rem 2.0)
          borderRadius (rem 0.6) (rem 0.6) (rem 0.6) (rem 0.6)
        ]
        [ text "Hello World!" ]
      ]
    ]

main :: Effect Unit
main = launchAff_ do
  body <- awaitBody
  void $ runUI (H.hoist runAppM component) unit body
