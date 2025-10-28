module App.Component.Common.Carrousel.Style.Carrousel
  ( classId
  , classIdWhenYoutubeVideo
  , style
  )
  where

import Proem hiding (top)

import App.Component.Common.Loader.Style.Loader as Loader
import App.Component.Common.PrettyErrorImage.Style.PrettyErrorImage as PrettyErrorImage
import App.Component.Common.PrettyErrorImage.Style.QuestionMark as QuestionMark
import App.Component.Common.YoutubeVideo.Style.YoutubeVideo as YoutubeVideo
import CSS (black, rgba, white, zIndex)
import CSS as CSS
import CSS.Background (backgroundColor)
import Color (darken)
import Util.Style (backgroundColorTransparent, borderRadiusRem1, centerToCenter, displayFlex, fill, flexGrow1, heightPct100, heightRem, justifyContentCenter, overflowHidden, positionRelative, raw, widthPct100, widthRem, (.?), (.|*.), (:&.), (:?), (:|*.))

classId :: String
classId = "bg2Md6TUT"

classIdWhenYoutubeVideo :: String
classIdWhenYoutubeVideo = "p1vA7JfNx"

style :: CSS.CSS
style = do
  classId .? do
    positionRelative
    displayFlex
    justifyContentCenter
    heightRem 30.0
    widthRem 55.0
    backgroundColor $ rgba 0 0 0 0.6
    borderRadiusRem1 0.6
    overflowHidden
    raw "transition" "background-color 0s"

  __image :? do 
    widthPct100
    heightPct100
    raw "object-fit" "contain"

  ____errored :? do
    backgroundColorTransparent
    flexGrow1

  ______questionMark :? do
    fill $ darken 0.16 white

  __youtubeVideo :? do 
    widthPct100
    heightPct100

  __loader :? do
    centerToCenter
  
  where 
  __image = classId .|*. PrettyErrorImage.classId 
  ____errored = __image :&. PrettyErrorImage.classIdWhenErrored
  ______questionMark = ____errored :|*. QuestionMark.classId
  __youtubeVideo = classId .|*. YoutubeVideo.classId 
  __loader = classId .|*. Loader.classId