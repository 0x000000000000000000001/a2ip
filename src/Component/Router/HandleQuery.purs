module Component.Router.HandleQuery where

import Proem hiding (div)

import Component.Router.Type (RouteM, Query(..))
import Data.Maybe (Maybe(..))
import Effect.Class (liftEffect)
import Halogen (modify_)
import Web.HTML (window)
import Web.HTML.Window (scroll)

handleQuery :: ∀ a. Query a -> RouteM (Maybe a)
handleQuery = case _ of
  Navigate route' a -> do
    -- Reset scroll to top
    win <- liftEffect window
    liftEffect $ scroll 0 0 win

    modify_ _ { route = route' }

    η (Just a) 
  