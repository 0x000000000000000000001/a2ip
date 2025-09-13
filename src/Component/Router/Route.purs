module Component.Router.Route
  ( Route(..)
  , routeCodec
  ) where

import Prelude

import Data.Generic.Rep (class Generic)
import Data.Show.Generic (genericShow)
import Routing.Duplex (RouteDuplex', path, root)
import Routing.Duplex.Generic (sum, noArgs)

data Route
  = Home
  | About

derive instance genericRoute :: Generic Route _
derive instance eqRoute :: Eq Route
derive instance ordRoute :: Ord Route

instance showRoute :: Show Route where
  show = genericShow

routeCodec :: RouteDuplex' Route
routeCodec = root $ sum
  { "Home": path "home" noArgs
  , "About": path "about" noArgs
  }
