module Main (main) where

import Prelude hiding (div)

import AppM (runAppM)
import CSS (StyleM, backgroundColor, borderRadius, display, flex, flexDirection, flexGrow, fromInt, margin, marginLeft, minHeight, padding, pct, rem, row, vh, width)
import Capability.Log (class Log)
import Capability.Navigate (class Navigate)
import Component.Menu.Component as MenuComponent
import Component.Menu.Style.Menu as MenuStyle
import Data.Const (Const)
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Aff (launchAff_)
import Effect.Aff.Class (class MonadAff)
import Effect.Class (liftEffect)
import Halogen as H
import Halogen.Aff (awaitBody)
import Halogen.HTML (div, slot)
import Halogen.HTML.CSS (style)
import Halogen.VDom.Driver (runUI)
import Route (parseRoute)
import Router.Router as Router
import Routing.Hash (matchesWith)
import Type.Proxy (Proxy(..))

type Slots = 
  ( menu :: H.Slot (Const Void) Void Unit
  , router :: H.Slot Router.Query Void Unit
  )

type State = Unit

data Action

mainLayoutStyles :: StyleM Unit
mainLayoutStyles = do
  display flex
  flexDirection row
  minHeight (vh 100.0)

component :: forall q o m. MonadAff m => Navigate m => Log m => H.Component q Unit o m
component = H.mkComponent
  { initialState: \_ -> unit
  , render
  , eval: H.mkEval H.defaultEval
  }

render :: forall m. MonadAff m => Navigate m => Log m => State -> H.ComponentHTML Action Slots m
render _ =
  div
    [ style mainLayoutStyles ]
    [ slot (Proxy :: Proxy "menu") unit MenuComponent.component unit absurd
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
        [ slot (Proxy :: Proxy "router") unit Router.component unit absurd ]
      ]
    ]

main :: Effect Unit
main = launchAff_ do
  body <- awaitBody
  io <- runUI (H.hoist runAppM component) unit body
  -- Listens to URL hash changes and updates the router state accordingly
  liftEffect $ matchesWith parseRoute
    \old' new -> when (old' /= Just new) $
      launchAff_ $ io.query $ H.mkTell $ Router.Navigate new
