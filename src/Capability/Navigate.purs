module Capability.Navigate where

import Proem

import Capability.AppM (AppM)
import Component.Router.Route (Route, routeCodec)
import Control.Monad.Trans.Class (lift)
import Effect.Class (liftEffect)
import Halogen (HalogenM)
import Routing.Duplex (print)
import Routing.Hash (setHash)

class Monad m <= Navigate m where
  navigate :: Route -> m Unit

instance navigateHalogenM :: Navigate m => Navigate (HalogenM state action slots output m) where
  navigate = lift <<< navigate

instance navigateAppM :: Navigate AppM where
  navigate = liftEffect <<< setHash <<< print routeCodec
