module App.Component.Common.YouTubeVideo.Style.YouTubeVideo
  ( classId
  , style
  ) where

import Proem hiding (top)

import CSS as CSS
import Util.Style (displayFlex, justifyContentCenter, (.?))

classId :: String
classId = "U7IRxxSNd"

style :: CSS.CSS
style = do
  classId .? do
    displayFlex
    justifyContentCenter