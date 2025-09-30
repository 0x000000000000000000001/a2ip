module Component.Router.Menu.HandleAction (handleAction) where

import Prelude hiding (top, div)

import AppM (AppM)
import Capability.Navigate (navigate)
import Component.Router.Menu.Type (Action(..), State, Output)
import Halogen as H
 
handleAction :: Action -> H.HalogenM State Action () Output AppM Unit
handleAction = case _ of
  ToggleFolding bool -> H.modify_ _ { isUnfold = not bool }
  Navigate route -> do 
    H.modify_ _ { isUnfold = false }
    navigate route 