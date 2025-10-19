module Component.Common.Separator.Component
  ( component
  )
  where

import Proem

import Capability.AppM (AppM)
import Component.Common.Separator.HandleAction (handleAction)
import Component.Common.Separator.Render (render)
import Component.Common.Separator.Type (Action(..), Input, Output, Query)
import Data.Maybe (Maybe(..))
import Halogen (Component, defaultEval, mkComponent, mkEval)

component :: Component Query Input Output AppM
component = mkComponent
    { initialState: \input -> 
      { text: input.text
      , loading: input.loading
      , withWings: input.withWings
      , withSofa: input.withSofa
      }
    , render   
    , eval: mkEval defaultEval 
      { handleAction = handleAction
      , receive = Just ◁ Receive
      }
    }