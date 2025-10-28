module App.Component.Common.YoutubeVideo.Component
  ( component
  ) where

import Proem

import App.Component.Common.YoutubeVideo.HandleAction (handleAction)
import App.Component.Common.YoutubeVideo.Render (render)
import App.Component.Common.YoutubeVideo.Type (Input, Output, Query, Action(..))
import App.Util.Capability.AppM (AppM)
import Data.Maybe (Maybe(..))
import Halogen (Component, defaultEval, mkComponent, mkEval)

component :: Component Query Input Output AppM
component = mkComponent
  { initialState: \input -> { url: input.url }
  , render
  , eval: mkEval defaultEval
    { handleAction = handleAction
    , receive = Just ◁ Receive
    }
  }