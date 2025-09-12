module Component.Menu.HandleAction (handleAction) where

import Prelude hiding (top, div)

import Capability.Log (class Log, LogLevel(..), log, logEntry)
import Capability.Navigate (class Navigate, navigate)
import Component.Menu.Type (Action(..), State, Output)
import Effect.Aff.Class (class MonadAff)
import Halogen as H

handleAction :: forall m. MonadAff m => Navigate m => Log m => Action -> H.HalogenM State Action () Output m Unit
handleAction = case _ of
  ToggleFolding bool -> H.modify_ _ { isUnfold = bool }
  NavigateToRoute route -> navigate route
  Log message -> logEntry Debug message >>= log