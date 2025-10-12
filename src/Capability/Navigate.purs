module Capability.Navigate where

import Proem

import Capability.AppM (AppM)
import Component.Router.Route (Route, routeCodec)
import Control.Monad.Trans.Class (lift)
import Effect.Class (liftEffect)
import Foreign (unsafeToForeign)
import Halogen (HalogenM)
import Routing.Duplex (print)
import Web.HTML (window)
import Web.HTML.Window (history)
import Web.HTML.History (DocumentTitle(..), URL(..), pushState) as History

class Monad m <= Navigate m where
  navigate :: Route -> m Unit

instance navigateHalogenM :: Navigate m => Navigate (HalogenM state action slots output m) where
  navigate = lift <<< navigate

instance navigateAppM :: Navigate AppM where
  navigate route = liftEffect do
    let path = print routeCodec route
    h <- window >>= history
    History.pushState (unsafeToForeign {}) (History.DocumentTitle "") (History.URL path) h
