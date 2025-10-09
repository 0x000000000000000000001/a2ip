module Component.Common.PrettyErrorImage.Component where

import Prelude

import Capability.AppM (AppM)
import Component.Common.PrettyErrorImage.HandleAction (handleAction)
import Component.Common.PrettyErrorImage.Render (render)
import Component.Common.PrettyErrorImage.Type (Input, Output, Query)
 
import Halogen (Component, defaultEval, mkComponent, mkEval)
 
component :: Component Query Input Output AppM
component = mkComponent
  { initialState: const
      { errored: false
      }
  , render
  , eval: mkEval defaultEval
      { handleAction = handleAction
      } 
  }