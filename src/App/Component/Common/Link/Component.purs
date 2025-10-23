module App.Component.Common.Link.Component
  ( component
  )
  where

import Proem

import App.Util.Capability.AppM (AppM)
import App.Component.Common.Link.HandleAction (handleAction)
import App.Component.Common.Link.Render (render)
import App.Component.Common.Link.Type (Action(..), Input, Output, Query)
import Data.Maybe (Maybe(..))
import Halogen (Component, defaultEval, mkComponent, mkEval)

component :: Component Query Input Output AppM
component = mkComponent
    { initialState: \input -> 
        { route: input.route
        , class_: input.class_
        , display: input.display
        , children: input.children
        }
    , render   
    , eval: mkEval defaultEval
        { handleAction = handleAction
        , receive = \input -> Just $ Receive input
        }
    }