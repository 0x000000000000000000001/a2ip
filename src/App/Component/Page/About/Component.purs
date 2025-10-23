module App.Component.Page.About.Component where

import Proem

import App.Util.Capability.AppM.AppM (AppM)
import App.Component.Page.About.HandleAction (handleAction)
import App.Component.Page.About.Render (render)
import App.Component.Page.About.Type (Action(..), Input, Query, Output)
import Data.Maybe (Maybe(..))
import Halogen (Component, defaultEval, mkComponent, mkEval)

component :: Component Query Input Output AppM
component = mkComponent
  { initialState: κ
      { members: Nothing
      , collaborators: Nothing
      }
  , render
  , eval: mkEval defaultEval
      { handleAction = handleAction
      , initialize = Just Load
      } 
  }