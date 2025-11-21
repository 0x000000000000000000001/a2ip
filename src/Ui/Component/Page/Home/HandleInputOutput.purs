module Ui.Component.Page.Home.HandleInputOutput
  ( handleInputOutput
  )
  where


import Ui.Component.Common.Input.Type as Input
import Ui.Component.Page.Home.Type (Action(..))

handleInputOutput :: Input.Output -> Action
handleInputOutput _ = DoNothing
