module App.Component.Common.YouTubeVideo.Style.YouTubeVideo
  ( classId
  , style
  ) where

import Proem hiding (top)

import CSS (iframe, star)
import CSS as CSS
import Util.Style (any, displayFlex, heightPct100, heightRem, justifyContentCenter, widthPct100, widthRem, (.&¨), (.?), (.|*), (.|*¨), (.|>), (.|>¨), (:?))

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

  __potentialIframeContainer :? do 
    widthPct100
    heightPct100

  __iframe :? do 
    widthPct100
    heightPct100
  
  where 
  __potentialIframeContainer = classId .|> any
  __iframe = classId .|* iframe