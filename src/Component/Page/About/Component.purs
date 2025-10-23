module Component.Page.About.Component where

import Proem

import Component.Util.Capability.AppM (AppM)
import Component.Page.About.HandleAction (handleAction)
import Component.Page.About.Render (render)
import Component.Page.About.Type (Action(..), Input, Query, Output)
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