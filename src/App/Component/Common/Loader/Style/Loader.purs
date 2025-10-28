module App.Component.Common.Loader.Style.Loader
  ( classId
  , style
  )
  where

import Proem hiding (top)

import CSS (Color, animation, borderBox, borderRight, borderTop, boxSizing, deg, forwards, fromString, infinite, keyframes, linear, normalAnimationDirection, rem, rotate, sec, solid, transform)
import CSS as CSS
import Data.NonEmpty ((:|))
import Data.Tuple.Nested ((/\))
import Util.Style (borderRadiusPct1, displayInlineBlock, heightRem, transparent, widthRem, (.?))

classId :: String
classId = "JO5IFna2S"

animationId :: String
animationId = "pO4inhLd9"

style :: Color -> CSS.CSS
style color = do
  classId .? do
    widthRem 3.0
    heightRem 3.0
    borderRadiusPct1 50.0
    displayInlineBlock
    borderTop solid (rem 0.4) color
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

  keyframes animationId $ (
    (0.0 /\ (transform $ rotate $ deg 0.0))
    :| [100.0 /\ (transform $ rotate $ deg 360.0)]
  )