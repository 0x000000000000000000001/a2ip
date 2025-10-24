module App.Component.Common.Modal.Component
  ( component
  ) where

import App.Component.Common.Modal.HandleAction (handleAction)
import App.Component.Common.Modal.Render (render)
import App.Component.Common.Modal.Type (Input, Output, Query)
import App.Component.Util.Type (noState')
import App.Util.Capability.AppM (AppM)
import Halogen (Component, defaultEval, mkComponent, mkEval)

component :: Component Query Input Output AppM
component = mkComponent
  { initialState: noState'
  , render
  , eval: mkEval defaultEval { handleAction = handleAction }
  }