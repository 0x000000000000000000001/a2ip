module App.Component.Common.YoutubeVideo.Style.YoutubeVideo
  ( class'
  , staticClass
  , style
  )
  where

import Proem hiding (top)

import App.Component.Common.Loader.Style.Loader as Loader
import App.Component.Common.YoutubeVideo.Type (State)
import App.Component.Util.Type (applyToSize)
import CSS (backgroundColor, black, height, iframe, width, zIndex, (&))
import CSS as CSS
import Util.Style.Style (any, centerToCenter, displayFlex, has, heightPct100, heightRem, inferClass, justifyContentCenter, noCss, positionRelative, reflectStaticClass, topLeftToTopLeft, widthPct100, widthRem, (.?), (.|*), (.|*.), (.|>), (:?))

staticClass :: String
staticClass = reflectStaticClass ι

class' :: String -> String
class' = inferClass staticClass

ratio :: Number 
ratio = 16.0 / 9.0

height_ :: Number
height_ = 25.0

style :: State -> CSS.CSS
style { id, input: { style: { width: width', height: height' } } } = do
  staticClass .? do
    positionRelative
    displayFlex
    justifyContentCenter
    widthRem $ ratio * height_
    heightRem height_
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

  class' id .? do 
    width' ?? (applyToSize width) ⇔ noCss
    height' ?? (applyToSize height) ⇔ noCss
  
  where 
  __potentialIframeContainer = staticClass .|> (any & has iframe)
  __iframe = staticClass .|* iframe
  __loader = staticClass .|*. Loader.staticClass

youtubeVideo :: ∀ w i. Node HTMLdiv w i
youtubeVideo props = div ([ class_ staticClass ] <> props)

youtubeVideo_ :: ∀ w i. Array (HTML w i) -> HTML w i
youtubeVideo_ = youtubeVideo []