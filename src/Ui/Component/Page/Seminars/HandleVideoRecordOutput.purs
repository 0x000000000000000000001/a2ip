module Ui.Component.Page.Seminars.HandleVideoRecordOutput
  ( handleVideoRecordOutput
  ) where

import Ui.Component.Common.Vault.Type as Vault
import Ui.Component.Page.Seminars.Type (Action(..))

handleVideoRecordOutput :: ∀ o. Vault.Output o -> Action
handleVideoRecordOutput _ = DoNothing
