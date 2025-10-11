module Component.Router.HandleQuery where

import Proem hiding (div)

import Capability.AppM (AppM)
import Component.Router.Type (Action, Query(..), Slots, State, Output)
import Data.Maybe (Maybe(..))
import Halogen (HalogenM, modify_)

handleQuery :: forall a. Query a -> HalogenM State Action Slots Output AppM (Maybe a)
handleQuery = case _ of
  Navigate route' a -> do
    modify_ _ { route = route' }
    pure (Just a) 
