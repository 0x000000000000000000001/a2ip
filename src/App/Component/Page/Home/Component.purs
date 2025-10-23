module App.Component.Page.Home.Component where

import App.Component.Page.Home.Render (render)
import App.Component.Page.Home.Type (Input, Query, Output)
import App.Component.Util.Type (noState')
import App.Util.Capability.AppM (AppM)
import Halogen (Component, defaultEval, mkComponent, mkEval)

component :: Component Query Input Output AppM
component = mkComponent
  { initialState: noState'
  , render
  , eval: mkEval defaultEval
  }