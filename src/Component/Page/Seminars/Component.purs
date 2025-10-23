module Component.Page.Seminars.Component where

import Proem

import Component.Util.Capability.AppM (AppM)
import Component.Page.Seminars.HandleAction (handleAction)
import Component.Page.Seminars.Render (render)
import Component.Page.Seminars.Type (Input, Output, Query, dates)
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