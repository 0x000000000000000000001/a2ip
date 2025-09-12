module Route
  ( Route(..)
  , parseRoute
  , routeToString
  )
  where

import Prelude

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

parseRoute :: String -> Route
parseRoute = case _ of
  "/" -> Home
  "/about" -> About
  _ -> NotFound
