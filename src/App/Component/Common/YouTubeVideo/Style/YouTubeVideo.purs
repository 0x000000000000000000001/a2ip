module App.Component.Common.YoutubeVideo.Style.YoutubeVideo
  ( classId
  , style
  ) where

import Proem hiding (top)

import App.Component.Common.Loader.Style.Loader as Loader
import CSS (backgroundColor, black, iframe, zIndex, (&))
import CSS as CSS
import Util.Style.Style (any, centerToCenter, displayFlex, reflectStatelessClass, has, heightPct100, heightRem, justifyContentCenter, positionRelative, topLeftToTopLeft, widthPct100, widthRem, (.?), (.|*), (.|*.), (.|>), (:?))

classId :: String
classId = reflectStatelessClass ι

ratio :: Number 
ratio = 16.0 / 9.0

height :: Number
height = 25.0

style :: CSS.CSS
style = do
  classId .? do
    positionRelative
    displayFlex
    justifyContentCenter
    widthRem $ ratio * height
    heightRem height
    backgroundColor black

  __potentialIframeContainer :? do 
    widthPct100
    heightPct100

  __iframe :? do 
    widthPct100
    heightPct100
    topLeftToTopLeft
    zIndex 2

  __loader :? do
    centerToCenter
    zIndex 1
  
  where 
  __potentialIframeContainer = classId .|> (any & has iframe)
  __iframe = classId .|* iframe
  __loader = classId .|*. Loader.classId