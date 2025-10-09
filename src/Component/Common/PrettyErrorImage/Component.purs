module Component.Common.PrettyErrorImage.Component
  ( component
  )
  where

import Capability.AppM (AppM)
import Component.Common.PrettyErrorImage.HandleAction (handleAction)
import Component.Common.PrettyErrorImage.Render (render)
import Component.Common.PrettyErrorImage.Type (Input, Output, Query)
import Halogen (Component, defaultEval, mkComponent, mkEval)
 
component :: Component Query Input Output AppM
component = mkComponent
  { initialState: \input ->
      { errored: false
      , innerProps: input.innerProps
      }
  , render
  , eval: mkEval defaultEval
      { handleAction = handleAction
      } 
  }