module App.Component.Common.YouTubeVideo.Render
  ( render
  ) where

import Proem hiding (div)

import App.Component.Common.YouTubeVideo.Type (Action, Slots, State)
import App.Util.Capability.AppM (AppM)
import Halogen (ComponentHTML)
import Halogen.HTML (text)

render :: State -> ComponentHTML Action Slots AppM
render s = text $ "youtube video: " <> s.url