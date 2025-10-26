module App.Component.Common.YouTubeVideo.HandleAction
  ( handleAction
  ) where

import Proem

import App.Component.Common.YouTubeVideo.Type (Action(..), YouTubeVideoM)
import Halogen (modify_)

handleAction :: Action -> YouTubeVideoM Unit
handleAction = case _ of
  Receive input -> modify_ _ { url = input.url }
