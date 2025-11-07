module App.Component.Common.Loader.Style.Animation
  ( classId
  , classIdWithColor
  , style
  )
  where

import Proem hiding (top)

import CSS (Color, animation, borderBox, borderRight, borderTop, boxSizing, deg, forwards, fromString, infinite, keyframes, linear, normalAnimationDirection, rem, rotate, sec, solid, transform)
import CSS as CSS
import Data.NonEmpty ((:|))
import Data.Tuple.Nested ((/\))
import Util.Style (borderRadiusPct50, displayInlineBlock, heightRem, refineClass, reflectHashModuleName, transparent, widthRem, (.?))

classId :: String
classId = reflectHashModuleName ι

classIdWithColor :: Color -> String
classIdWithColor color = refineClass classId $ show color

animationId :: String
animationId = refineClass classId "animation"

style :: Color -> CSS.CSS
style color = do
  classId .? do
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

  classIdWithColor color .? do
    borderTop solid (rem 0.4) color