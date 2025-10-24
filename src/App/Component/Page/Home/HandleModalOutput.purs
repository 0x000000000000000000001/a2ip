module App.Component.Page.Home.HandleModalOutput
  ( handleModalOutput
  )
  where


import App.Component.Common.Modal.Type (Output(..))
import App.Component.Common.Modal.Type as Modal
import App.Component.Page.Home.Type (Action(..))

handleModalOutput :: Modal.Output -> Action
handleModalOutput = case _ of
  Closed -> HideModal
