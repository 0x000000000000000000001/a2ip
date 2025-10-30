module App.Component.Page.Seminars.Component where

import Proem

import App.Component.Page.Seminars.HandleAction (handleAction)
import App.Component.Page.Seminars.Render (render)
import App.Component.Page.Seminars.Type (Action(..), Input, Output, Query)
import App.Util.Capability.AppM (AppM)
import Data.Maybe (Maybe(..))
import Halogen (Component, defaultEval, mkComponent, mkEval)
import Network.RemoteData (RemoteData(..))

component :: Component Query Input Output AppM
component = mkComponent
  { initialState: κ NotAsked
  , render
  , eval: mkEval defaultEval
      { handleAction = handleAction
      , initialize = Just Load
      }
  }