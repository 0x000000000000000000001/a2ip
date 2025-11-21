module Ui.Util.Capability.Navigate where

import Proem

import Ui.Util.Capability.AppM (AppM)
import Control.Monad.Trans.Class (lift)
import Data.Generic.Rep (class Generic)
import Data.Show.Generic (genericShow)
import Effect (Effect)
import Foreign (unsafeToForeign)
import Halogen (HalogenM)
import Routing.Duplex (RouteDuplex', path, print, root)
import Routing.Duplex.Generic (noArgs, sum)
import Web.HTML (window)
import Web.HTML.HTMLDocument (setTitle)
import Web.HTML.History (DocumentTitle(..), URL(..), pushState)
import Web.HTML.Window (document, history)

foreign import dispatchPopStateEvent :: Effect Unit

data Route
  = Home
  | Seminars
  | About

routeCodec :: RouteDuplex' Route
routeCodec = root $ sum
  { "Home": noArgs
  , "Seminars": path "seminars" noArgs
  , "About": path "about" noArgs
  }

routeSubtitle :: Route -> String
routeSubtitle route = case route of
  About -> "Bureau et collaborateurs"
  Seminars -> "Séminaires"
  _ -> ""

routePath :: Route -> String
routePath = print routeCodec 

routeTitle :: Route -> String
routeTitle route = "A2IP" <> (subtitle /= "" ? " / " <> subtitle ↔ "")
  where
  subtitle = routeSubtitle route

derive instance genericRoute :: Generic Route _
derive instance eqRoute :: Eq Route
derive instance ordRoute :: Ord Route

instance showRoute :: Show Route where
  show = genericShow

class Monad m <= Navigate m where
  navigate :: Route -> m Unit

instance navigateHalogenM :: Navigate m => Navigate (HalogenM state action slots output m) where
  navigate = lift ◁ navigate

instance navigateAppM :: Navigate AppM where
  navigate route = ʌ do
    let path = routePath route
    let title = routeTitle route

    hist <- window >>= history
    pushState (unsafeToForeign {}) (DocumentTitle title) (URL path) hist
    -- Dispatch popstate event to trigger nav.listen in Main
    dispatchPopStateEvent

    doc <- window >>= document
    setTitle title doc

