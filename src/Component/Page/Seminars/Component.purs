module Component.Page.Seminars.Component where

import Proem

import Capability.AppM (AppM)
import Component.Page.Seminars.HandleAction (handleAction)
import Component.Page.Seminars.Render (render)
import Component.Page.Seminars.Type (Input, Output, Query)
import Data.Maybe (Maybe(..))
import Halogen (Component, defaultEval, mkComponent, mkEval)

component :: Component Query Input Output AppM
component = mkComponent
  { initialState: κ 
    { selectedDate: Nothing
    }
  , render
  , eval: mkEval defaultEval
      { handleAction = handleAction 
      } 
  }