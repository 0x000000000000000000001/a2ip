module Ui.Component.Page.Home.HandleModalOutput
  ( handleModalOutput
  )
  where


import Ui.Component.Common.Modal.Type (Output(..))
import Ui.Component.Common.Modal.Type as Modal
import Ui.Component.Page.Home.Type (Action(..))

handleModalOutput :: ∀ o. Modal.Output o -> Action
handleModalOutput = case _ of
  Closed -> HideModal
  InnerOutputRaised innerOutput -> case innerOutput of
    _ -> DoNothing
