module App.Component.Common.YouTubeVideo.Component
  ( component
  ) where

import App.Component.Common.YouTubeVideo.Render (render)
import App.Component.Common.YouTubeVideo.Type (Input, Output, Query)
import App.Component.Util.Type (noState')
import App.Util.Capability.AppM (AppM)
import Halogen (Component, defaultEval, mkComponent, mkEval)

component :: Component Query Input Output AppM
component = mkComponent
  { initialState: noState'
  , render
  , eval: mkEval defaultEval
  }