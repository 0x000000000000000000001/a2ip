module Component.Common.Timeline.Component
  ( component
  )
  where

import Proem

import Capability.AppM (AppM)
import Component.Common.Timeline.HandleAction (handleAction)
import Component.Common.Timeline.Render (render)
import Component.Common.Timeline.Type (Action(..), Input, Output, Query)
import Data.Maybe (Maybe(..))
import Halogen (Component, defaultEval, mkComponent, mkEval)

component :: Component Query Input Output AppM
component = mkComponent
    { initialState: \input -> 
      { class_: input.class_ 
      , dates: input.dates
      }
    , render
    , eval: mkEval defaultEval
        { handleAction = handleAction
        , receive = Just ◁ Receive
        } 
    }