module App.Component.Common.YoutubeVideo.HandleAction
  ( handleAction
  ) where

import Proem

import App.Component.Common.YoutubeVideo.Type (Action(..), YoutubeVideoM)
import Halogen (get, modify_)

handleAction :: Action -> YoutubeVideoM Unit
handleAction = case _ of
  Initialize -> ηι

  Receive input -> do 
    state <- get

     -- Avoid rerender whenever possible, because the iframe is sensitive...
    when (state.input /= input) do
      modify_ _ { input = input }
