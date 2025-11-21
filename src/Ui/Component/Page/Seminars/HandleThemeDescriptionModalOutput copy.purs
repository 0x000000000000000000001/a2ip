module Ui.Component.Page.Seminars.HandleThemeDescriptionModalOutput
  ( handleThemeDescriptionModalOutput
  ) where

import Ui.Component.Common.Modal.Type (Output(..))
import Ui.Component.Common.Modal.Type as Modal
import Ui.Component.Page.Seminars.Type (Action(..))

handleThemeDescriptionModalOutput :: ∀ o. Modal.Output o -> Action
handleThemeDescriptionModalOutput Closed = CloseThemeDescriptionModal
handleThemeDescriptionModalOutput _ = DoNothing
