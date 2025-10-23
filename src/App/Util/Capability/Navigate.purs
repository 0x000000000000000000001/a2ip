module App.Util.Capability.Navigate where

import Proem

import Data.Generic.Rep (class Generic)
import Data.Show.Generic (genericShow)
import Halogen (HalogenM)
import Routing.Duplex (RouteDuplex', path, print, root)
import Routing.Duplex.Generic (noArgs, sum)
import Control.Monad.Trans.Class (lift)

class Monad m <= Navigate m where
  navigate :: Route -> m Unit

instance navigateHalogenM :: Navigate m => Navigate (HalogenM state action slots output m) where
  navigate = lift ◁ navigate

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

