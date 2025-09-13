module Component.Router.HandleQuery where

import Prelude hiding (div)

import Component.Router.Type (Action, Query(..), State)
import Data.Maybe (Maybe(..))
import Effect.Aff.Class (class MonadAff)
import Halogen as H

handleQuery :: forall a o m. MonadAff m => Query a -> H.HalogenM State Action () o m (Maybe a)
handleQuery = case _ of
  Navigate route' a -> do
    H.modify_ _ { route = route' }
    pure (Just a)
