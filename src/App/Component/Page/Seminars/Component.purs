module App.Component.Page.Seminars.Component where

import Proem

import App.Util.Capability.AppM (AppM)
import App.Component.Page.Seminars.HandleAction (handleAction)
import App.Component.Page.Seminars.Render (render)
import App.Component.Page.Seminars.Type (Input, Output, Query, dates)
import Data.Array ((!!))
import Halogen (Component, defaultEval, mkComponent, mkEval)

component :: Component Query Input Output AppM
component = mkComponent
  { initialState: κ
      { selectedDate: dates !! 0
      }
  , render
  , eval: mkEval defaultEval
      { handleAction = handleAction
      }
  }