module App.Component.Common.YoutubeVideo.HandleAction
  ( handleAction
  ) where

import Proem

import App.Component.Common.YoutubeVideo.Type (Action(..), YoutubeVideoM)
import App.Util.Capability.Log (debugShow)
import Halogen (get, modify_)

handleAction :: Action -> YoutubeVideoM Unit
handleAction = case _ of
  Receive input -> do 
    state <- get

    debugShow (state.input /= input)
    
    when (state.input /= input) do
      modify_ _ { input = input }
