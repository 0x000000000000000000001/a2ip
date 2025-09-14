module Main (main) where

import Prelude hiding (div)

import AppM (runAppM)
import Component.Router.Component as RouterComponent
import Component.Router.Route (routeCodec)
import Component.Router.Type as RouterType
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Aff (launchAff_)
import Effect.Class (liftEffect)
import Halogen as H
import Halogen.Aff (awaitBody, runHalogenAff)
import Halogen.VDom.Driver (runUI)
import Routing.Duplex (parse)
import Routing.Hash (matchesWith)

main :: Effect Unit
main = runHalogenAff do
  body <- awaitBody
  io <- runUI (H.hoist runAppM RouterComponent.component) unit body
  liftEffect $ matchesWith (parse routeCodec)
    \old' new -> when (old' /= Just new) $   
      launchAff_ $ void $ io.query $ H.mkTell $ RouterType.Navigate new
