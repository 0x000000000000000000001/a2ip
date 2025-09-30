module Component.Router.HandleQuery where

import Prelude hiding (div)

import Capability.AppM (AppM)
import Component.Router.Type (Action, Query(..), State, Slots)
import Data.Maybe (Maybe(..))
import Halogen as H

handleQuery :: forall a o. Query a -> H.HalogenM State Action Slots o AppM (Maybe a)
handleQuery = case _ of
  Navigate route' a -> do
    H.modify_ _ { route = route' }
    pure (Just a) 
