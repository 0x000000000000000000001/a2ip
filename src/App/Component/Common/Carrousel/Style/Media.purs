module App.Component.Common.Carrousel.Style.Media
  ( classId
  , classIdWhenYoutubeVideo
  , style
  )
  where

import Proem hiding (top)

import App.Component.Common.PrettyErrorImage.Style.PrettyErrorImage as PrettyErrorImage
import App.Component.Common.PrettyErrorImage.Style.QuestionMark as QuestionMark
import App.Component.Common.YoutubeVideo.Style.YoutubeVideo as YoutubeVideo
import CSS (StyleM, black, white)
import CSS as CSS
import CSS.Background (backgroundColor)
import Color (darken)
import Util.Proxy.Dictionary.YoutubeVideo (youtubeVideo_)
import Util.Style (backgroundColorTransparent, fill, flexGrow1, heightPct100, positionRelative, raw, refineClassId, reflectHashModuleName, topLeftToTopLeft, widthPct100, (.?), (.|*.), (:&.), (:?), (:|*.))

classId :: String
classId = reflectHashModuleName ι

classIdWhenYoutubeVideo :: String
classIdWhenYoutubeVideo = refineClassId classId youtubeVideo_

style :: CSS.CSS
style = do
  classId .? do
    positionRelative
    widthPct100
    heightPct100
    topLeftToTopLeft
    raw "transition" "background-color 0s"

  __image :? do 
    asset
    raw "object-fit" "contain"

  ____errored :? do
    backgroundColorTransparent
    flexGrow1

  ______questionMark :? do
    fill $ darken 0.16 white

  classIdWhenYoutubeVideo .? do 
    backgroundColor black

  __youtubeVideo :? do 
    asset

  where 
  __image = classId .|*. PrettyErrorImage.classId 
  ____errored = __image :&. PrettyErrorImage.classIdWhenErrored
  ______questionMark = ____errored :|*. QuestionMark.classId
  __youtubeVideo = classId .|*. YoutubeVideo.classId 

asset ∷ StyleM Unit
asset = do 
  positionRelative
  widthPct100
  heightPct100