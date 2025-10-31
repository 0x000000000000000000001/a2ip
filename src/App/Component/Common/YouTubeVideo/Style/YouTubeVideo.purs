module App.Component.Common.YoutubeVideo.Style.YoutubeVideo
  ( classId
  , style
  ) where

import Proem hiding (top)

import CSS (backgroundColor, black, iframe)
import CSS as CSS
import Util.Style (any, displayFlex, heightPct100, heightRem, justifyContentCenter, widthPct100, widthRem, (.?), (.|*), (.|>), (:?))

classId :: String
classId = "U7IRxxSNd"

ratio :: Number 
ratio = 16.0 / 9.0

height :: Number
height = 25.0

style :: CSS.CSS
style = do
  classId .? do
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
  
  where 
  __potentialIframeContainer = classId .|> any
  __iframe = classId .|* iframe