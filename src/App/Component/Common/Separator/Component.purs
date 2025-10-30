module App.Component.Common.Separator.Component
  ( component
  )
  where

import Proem

import App.Util.Capability.AppM (AppM)
import App.Component.Common.Separator.HandleAction (handleAction)
import App.Component.Common.Separator.Render (render)
import App.Component.Common.Separator.Type (Action(..), Input, Output, Query)
import Data.Maybe (Maybe(..))
import Halogen (Component, defaultEval, mkComponent, mkEval)

component :: Component Query Input Output AppM
component = mkComponent
    { initialState: \input -> 
      { text: input.text
      , textElementTag: input.textElementTag
      , loading: input.loading
      }
    , render   
    , eval: mkEval defaultEval 
      { handleAction = handleAction
      , receive = Just ◁ Receive
      }
    }