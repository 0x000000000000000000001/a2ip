module Component.Router.HandleQuery where

import Prelude hiding (div)

import AppM (AppM)
import Capability.Log (class Log)
import Component.Router.Type (Action, Query(..), State, Slots)
import Data.Maybe (Maybe(..))
import Effect.Aff.Class (class MonadAff)
import Halogen as H

handleQuery :: forall a o. Query a -> H.HalogenM State Action Slots o AppM (Maybe a)
handleQuery = case _ of
  Navigate route' a -> do
    H.modify_ _ { route = route' }
    pure (Just a) 
