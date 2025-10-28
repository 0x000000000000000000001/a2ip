module App.Component.Common.Carrousel.Style.Media
  ( classId
  , classIdWhenYoutubeVideo
  , style
  )
  where

import Proem hiding (top)

import CSS (black, zIndex)
import CSS as CSS
import CSS.Background (backgroundColor)
import Util.Style (heightPct100, positionRelative, raw, topLeftToTopLeft, widthPct100, (.?))

classId :: String
classId = "g3hSj8Cu1"

classIdWhenYoutubeVideo :: String
classIdWhenYoutubeVideo = "riv3owYF6"

style :: CSS.CSS
style = do
  classId .? do
    positionRelative
    widthPct100
    heightPct100
    topLeftToTopLeft
    raw "transition" "background-color 0s"

  classIdWhenYoutubeVideo .? do 
    backgroundColor black