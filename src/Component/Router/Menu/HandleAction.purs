module Component.Router.Menu.HandleAction (handleAction) where

import Prelude hiding (top, div)

import Capability.Navigate (class Navigate, navigate)
import Component.Router.Menu.Type (Action(..), State, Output)
import Effect.Aff.Class (class MonadAff)
import Halogen as H

handleAction :: forall m. MonadAff m => Navigate m => Action -> H.HalogenM State Action () Output m Unit
handleAction = case _ of
  ToggleFolding bool -> H.modify_ _ { isUnfold = not bool }
  Navigate route -> do 
    H.modify_ _ { isUnfold = false }
    navigate route 