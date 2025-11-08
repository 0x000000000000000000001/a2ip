module App.Component.Common.Loader.Style.Animation
  ( class'
  , classWithColor
  , style
  )
  where

import Proem hiding (top)

import CSS (Color, animation, borderBox, borderRight, borderTop, boxSizing, deg, forwards, fromString, infinite, keyframes, linear, normalAnimationDirection, rem, rotate, sec, solid, transform)
import CSS as CSS
import Data.NonEmpty ((:|))
import Data.Tuple.Nested ((/\))
import Util.Proxy.Dictionary.Color (color_)
import Util.Style.Style (borderRadiusPct50, displayInlineBlock, heightRem, inferAnimationId, refineClass, reflectStatelessClass, transparent, widthRem, (.?))

class' :: String
class' = reflectStatelessClass ι

classWithColor :: Color -> String
classWithColor color = refineClass class' color_ $ show color

animationId :: String
animationId = inferAnimationId class'

style :: Color -> CSS.CSS
style color = do
  class' .? do
    widthRem 3.0
    heightRem 3.0
    borderRadiusPct50
    displayInlineBlock
    borderRight solid (rem 0.4) transparent
    boxSizing borderBox

    animation 
      (fromString animationId) 
      (sec 0.5)
      linear
      (sec 0.0)
      infinite
      normalAnimationDirection
      forwards

  keyframes animationId (
    (0.0 /\ (transform $ rotate $ deg 0.0))
    :| [100.0 /\ (transform $ rotate $ deg 360.0)]
  )

  classWithColor color .? do
    borderTop solid (rem 0.4) color