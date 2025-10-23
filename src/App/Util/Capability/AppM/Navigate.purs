module App.Util.Capability.AppM.Navigate (AppM, runAppM) where

import Proem

import Config.Config (Config)
import Control.Monad.Error.Class (class MonadError, class MonadThrow)
import Control.Monad.Reader (class MonadAsk, ReaderT, runReaderT)
import Effect.Aff (Aff)
import Effect.Aff.Class (class MonadAff)
import Effect.Class (class MonadEffect)
import Effect.Exception (Error)
import Data.Generic.Rep (class Generic)
import Data.Show.Generic (genericShow)
import Routing.Duplex (RouteDuplex', print, path, root)
import Routing.Duplex.Generic (sum, noArgs)

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

instance navigateAppM :: Navigate AppM where
  navigate route = liftEffect do
    let path = routePath route
    let title = routeTitle route

    hist <- window >>= history
    pushState (unsafeToForeign {}) (DocumentTitle title) (URL path) hist
    -- Dispatch popstate event to trigger nav.listen in Main
    dispatchPopStateEvent

    doc <- window >>= doc

derive instance genericRoute :: Generic Route _
derive instance eqRoute :: Eq Route
derive instance ordRoute :: Ord Route

instance showRoute :: Show Route where
  show = genericShow
