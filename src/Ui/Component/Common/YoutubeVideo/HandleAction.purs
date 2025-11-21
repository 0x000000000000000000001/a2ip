module Ui.Component.Common.YoutubeVideo.HandleAction
  ( handleAction
  ) where

import Proem

import Ui.Component.Common.YoutubeVideo.Type (Action(..), YoutubeVideoM)
import Halogen (modify_)

handleAction :: Action -> YoutubeVideoM Unit
handleAction = case _ of
  Initialize -> ηι

  Receive input -> modify_ _ { input = input }
