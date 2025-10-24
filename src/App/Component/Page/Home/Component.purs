module App.Component.Page.Home.Component where

import App.Component.Page.Home.HandleAction (handleAction)
import App.Component.Page.Home.Render (render)
import App.Component.Page.Home.Type (Input, Query, Output)
import App.Util.Capability.AppM (AppM)
import Halogen (Component, defaultEval, mkComponent, mkEval)
import Proem (κ)

component :: Component Query Input Output AppM
component = mkComponent
  { initialState: κ
      { showModal: false
      }
  , render
  , eval: mkEval defaultEval 
      { handleAction = handleAction 
      }
  }