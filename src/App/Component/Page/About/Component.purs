module App.Component.Page.About.Component where

import Proem

import App.Component.Page.About.HandleAction (handleAction)
import App.Component.Page.About.Render (render)
import App.Component.Page.About.Type (Action(..), Input, Query, Output)
import App.Util.Capability.AppM (AppM)
import Data.Maybe (Maybe(..))
import Halogen (Component, defaultEval, mkComponent, mkEval)
import Network.RemoteData (RemoteData(..))

component :: Component Query Input Output AppM
component = mkComponent
  { initialState: κ
      { members: NotAsked
      , collaborators: NotAsked
      }
  , render
  , eval: mkEval defaultEval
      { handleAction = handleAction
      , initialize = Just Load
      } 
  }