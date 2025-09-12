module Capability.Navigate where

import Prelude

import Router.Routes (Route, routeToString)
import Halogen as H
import Routing.Hash (setHash)
import Effect.Class (class MonadEffect, liftEffect)

class Monad m <= Navigate m where
  navigate :: Route -> m Unit

instance navigateHalogenM :: MonadEffect m => Navigate (H.HalogenM state action slots output m) where
  navigate route = liftEffect $ setHash $ routeToString route
