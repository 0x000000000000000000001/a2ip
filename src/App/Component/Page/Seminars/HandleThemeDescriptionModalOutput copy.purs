module App.Component.Page.Seminars.HandleThemeDescriptionModalOutput
  ( handleThemeDescriptionModalOutput
  ) where

import App.Component.Common.Modal.Type (Output(..))
import App.Component.Common.Modal.Type as Modal
import App.Component.Page.Seminars.Type (Action(..))

handleThemeDescriptionModalOutput :: ∀ o. Modal.Output o -> Action
handleThemeDescriptionModalOutput Closed = CloseThemeDescriptionModal
handleThemeDescriptionModalOutput _ = DoNothing
