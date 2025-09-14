module Component.Router.HandleQuery where

import Prelude hiding (div)

import Capability.Log (class Log)
import Component.Router.Type (Action, Query(..), State, Slots)
import Data.Maybe (Maybe(..))
import Effect.Aff.Class (class MonadAff)
import Halogen as H

handleQuery :: forall a o m. MonadAff m => Log m => Query a -> H.HalogenM State Action Slots o m (Maybe a)
handleQuery = case _ of
  Navigate route' a -> do
    H.modify_ _ { route = route' }
    pure (Just a) 
