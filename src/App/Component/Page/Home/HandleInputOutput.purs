module App.Component.Page.Home.HandleInputOutput
  ( handleInputOutput
  )
  where


import App.Component.Common.Input.Type as Input
import App.Component.Page.Home.Type (Action(..))

handleInputOutput :: Input.Output -> Action
handleInputOutput _ = DoNothing
