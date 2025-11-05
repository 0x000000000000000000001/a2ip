module App.Component.Page.Seminars.HandleVideoRecordOutput
  ( handleVideoRecordOutput
  ) where

import App.Component.Common.Vault.Type as Vault
import App.Component.Page.Seminars.Type (Action(..))

handleVideoRecordOutput :: ∀ o. Vault.Output o -> Action
handleVideoRecordOutput _ = DoNothing
