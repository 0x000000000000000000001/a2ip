module App.Component.Page.Home.HandleInputOutput
  ( handleInputOutput
  )
  where


import App.Component.Common.Input.Type (Output(..))
import App.Component.Common.Input.Type as Input
import App.Component.Page.Home.Type (Action(..))
import Data.Lens (_1)

handleInputOutput :: Input.Output -> Action
handleInputOutput = case _ of
  ChangedValue _1 -> DoNothing
  _ -> DoNothing
