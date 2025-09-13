module Component.Router.HandleQuery where

import Prelude hiding (div)

import Component.Router.Type (Action, Query(..), State)
import Data.Maybe (Maybe(..))
import Effect.Aff.Class (class MonadAff)
import Effect.Class (class MonadEffect, liftEffect)
import Effect.Class.Console as Console
import Halogen as H

handleQuery :: forall a o m. MonadAff m => MonadEffect m => Query a -> H.HalogenM State Action () o m (Maybe a)
handleQuery = case _ of
  Navigate route' a -> do
    liftEffect $ Console.log $ "🔄 Router: Navigating to " <> show route'
    H.modify_ _ { route = route' }
    pure (Just a) 
