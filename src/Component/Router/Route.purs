module Component.Router.Route
  ( Route(..)
  , parseRoute
  , routeToString
  )
  where

import Prelude

import Data.Maybe (Maybe(..))

data Route 
  = Home
  | About  
  | NotFound

derive instance eqRoute :: Eq Route
derive instance ordRoute :: Ord Route

routeToString :: Route -> String
routeToString = case _ of
  Home -> "/"
  About -> "/about"
  NotFound -> "/404"

parseRoute :: String -> Maybe Route
parseRoute = case _ of
  "/" -> Just Home
  "/about" -> Just About
  _ -> Nothing
