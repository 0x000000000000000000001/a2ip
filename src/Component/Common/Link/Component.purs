module Component.Common.Link.Component
  ( component
  )
  where

import Proem

import Capability.AppM (AppM)
import Component.Common.Link.HandleAction (handleAction)
import Component.Common.Link.Render (render)
import Component.Common.Link.Type (Action(..), Input, Output, Query)
import Data.Maybe (Maybe(..))
import Halogen (Component, defaultEval, mkComponent, mkEval)

component :: Component Query Input Output AppM
component = mkComponent
    { initialState: \input -> 
        { route: input.route
        , class_: input.class_
        , children: input.children
        }
    , render   
    , eval: mkEval defaultEval
        { handleAction = handleAction
        , receive = \input -> Just $ Receive input
        }
    }