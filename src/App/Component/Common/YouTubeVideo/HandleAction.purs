module App.Component.Common.YoutubeVideo.HandleAction
  ( handleAction
  ) where

import Proem

import App.Component.Common.YoutubeVideo.Type (Action(..), YoutubeVideoM)
import Halogen (modify_)

handleAction :: Action -> YoutubeVideoM Unit
handleAction = case _ of
  Receive input -> modify_ _ { url = input.url }
