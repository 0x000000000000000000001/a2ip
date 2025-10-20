module Component.Router.Route
  ( Route(..)
  , routeCodec
  , routePath
  , routeSubtitle
  , routeTitle
  )
  where

import Proem

import Data.Generic.Rep (class Generic)
import Data.Show.Generic (genericShow)
import Routing.Duplex (RouteDuplex', print, path, root)
import Routing.Duplex.Generic (sum, noArgs)

data Route
  = Home
  | Seminars
  | About

derive instance genericRoute :: Generic Route _
derive instance eqRoute :: Eq Route
derive instance ordRoute :: Ord Route

instance showRoute :: Show Route where
  show = genericShow

routeCodec :: RouteDuplex' Route
routeCodec = root $ sum
  { "Home": noArgs
  , "Seminars": path "seminars" noArgs
  , "About": path "about" noArgs
  }

routePath :: Route -> String
routePath = print routeCodec 

routeSubtitle :: Route -> String
routeSubtitle route = case route of
  About -> "Bureau et collaborateurs"
  Seminars -> "Séminaires"
  _ -> ""

routeTitle :: Route -> String
routeTitle route = "A2IP" <> (subtitle /= "" ? " / " <> subtitle ↔ "")
  where
  subtitle = routeSubtitle route
