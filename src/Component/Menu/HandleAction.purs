module Component.Menu.HandleAction (handleAction) where

import Prelude hiding (top, div)

import Component.Menu.Type (Action(..), State, Output)
import Effect.Aff.Class (class MonadAff)
import Halogen as H
import Capability.Navigate (navigate)

handleAction :: forall m. MonadAff m => Action -> H.HalogenM State Action () Output m Unit
handleAction = case _ of
  ToggleFolding bool -> H.modify_ _ { isUnfold = bool }
  NavigateToRoute route -> navigate route