module Component.Common.PrettyErrorImage.Component
  ( component
  )
  where

import Prelude

import Capability.AppM (AppM)
import Component.Common.PrettyErrorImage.HandleAction (handleAction)
import Component.Common.PrettyErrorImage.Render (render)
import Component.Common.PrettyErrorImage.Type (Input, Output, Query)
import Halogen (Component, defaultEval, mkComponent, mkEval)
import Safe.Coerce (coerce)

component :: forall r i. Component Query (Input r i) Output AppM
component = coerce $ mkComponent
    { initialState: \input ->
        { errored: false 
        , iProps: input.iProps 
        }
    , render  
    , eval: mkEval defaultEval
        { handleAction = handleAction
        } 
    } 