module Capability.Navigate where

import Proem

import Capability.AppM (AppM)
import Component.Router.Route (Route, routePath, routeTitle)
import Control.Monad.Trans.Class (lift)
import Effect (Effect)
import Effect.Class (liftEffect)
import Foreign (unsafeToForeign)
import Halogen (HalogenM)
import Web.HTML (window)
import Web.HTML.HTMLDocument (setTitle)
import Web.HTML.History (DocumentTitle(..), URL(..), pushState)
import Web.HTML.Window (document, history)

foreign import dispatchPopStateEvent :: Effect Unit

class Monad m <= Navigate m where
  navigate :: Route -> m Unit

instance navigateHalogenM :: Navigate m => Navigate (HalogenM state action slots output m) where
  navigate = lift ◁ navigate

instance navigateAppM :: Navigate AppM where
  navigate route = liftEffect do
    let path = routePath route
    let title = routeTitle route

    hist <- window >>= history
    pushState (unsafeToForeign {}) (DocumentTitle title) (URL path) hist
    -- Dispatch popstate event to trigger nav.listen in Main
    dispatchPopStateEvent

    doc <- window >>= document
    setTitle title doc
