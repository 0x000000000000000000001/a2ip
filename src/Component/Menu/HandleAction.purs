module Component.Menu.HandleAction (handleAction) where

import Prelude hiding (top, div)

import Component.Menu.Type (Action(..), State)
import Effect.Aff.Class (class MonadAff)
import Halogen as H

handleAction :: forall o m. MonadAff m => Action -> H.HalogenM State Action () o m Unit
handleAction = case _ of
  ToggleFolding bool -> H.modify_ _ { isUnfold = bool }