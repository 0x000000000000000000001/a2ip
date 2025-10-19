module Component.Common.Carrousel.Component
  ( component
  ) where

import Proem

import Capability.AppM (AppM)
import Component.Common.Carrousel.HandleAction (handleAction)
import Component.Common.Carrousel.Render (render)
import Component.Common.Carrousel.Type (Action(..), Input, Output, Query)
import Data.Maybe (Maybe(..))
import Halogen (Component, defaultEval, mkComponent, mkEval)

component :: Component Query Input Output AppM
component = mkComponent
  { initialState: κ { index: 0, imageSources: [] }
  , render
  , eval: mkEval defaultEval
      { handleAction = handleAction
      , receive = Just ◁ Receive
      }
  }