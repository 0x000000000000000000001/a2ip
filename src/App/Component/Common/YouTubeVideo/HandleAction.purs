module App.Component.Common.YoutubeVideo.HandleAction
  ( handleAction
  ) where

import Proem

import App.Component.Common.YoutubeVideo.Type (Action(..), YoutubeVideoM)
import Halogen (modify_)

handleAction :: ∀ u. Action u -> YoutubeVideoM u Unit
handleAction = case _ of
  Initialize -> ηι

  Receive input -> modify_ _ { input = input }
