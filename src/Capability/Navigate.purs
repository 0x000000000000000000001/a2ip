module Capability.Navigate where

import Prelude

import AppM (AppM)
import Control.Monad.Trans.Class (lift)
import Effect.Class (liftEffect)
import Halogen (HalogenM)
import Router.Routes (Route, routeToString)
import Routing.Hash (setHash)

class Monad m <= Navigate m where
  navigate :: Route -> m Unit

instance navigateHalogenM :: Navigate m => Navigate (HalogenM state action slots output m) where
  navigate = lift <<< navigate

instance navigateAppM :: Navigate AppM where
  navigate route = liftEffect $ setHash $ routeToString route
