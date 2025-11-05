module App.Component.Common.YoutubeVideo.HandleAction
  ( handleAction
  ) where

import Proem

import App.Component.Common.YoutubeVideo.Type (Action(..), YoutubeVideoM)
import App.Util.Capability.Log (debugShow)
import Halogen (get, modify_)

handleAction :: Action -> YoutubeVideoM Unit
handleAction = case _ of
  Initialize -> 
    debugShow "init"

  Receive input -> do 
    state <- get

     -- Avoid rerender whenever possible, because the iframe is sensitive...
    when (state.input /= input) do
      modify_ _ { input = input }
