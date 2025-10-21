module Component.Router.HandleQuery where

import Proem hiding (div)

import Component.Router.Type (RouteM, Query(..))
import Data.Maybe (Maybe(..))
import Halogen (modify_)

handleQuery :: ∀ a. Query a -> RouteM (Maybe a)
handleQuery = case _ of
  Navigate route' a -> do
    modify_ _ { route = route' }
    η (Just a) 
