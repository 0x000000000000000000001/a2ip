module App.Component.Common.Loader.Style.Animation
  ( animation
  , animation_
  , classWithColor
  , staticClass
  , style
  )
  where

import Proem hiding (div, top)

import CSS (Color, borderBox, borderRight, borderTop, boxSizing, deg, forwards, fromString, infinite, keyframes, linear, normalAnimationDirection, rem, rotate, sec, solid, transform)
import CSS as CSS
import DOM.HTML.Indexed (HTMLdiv)
import Data.NonEmpty ((:|))
import Data.Tuple.Nested ((/\))
import Halogen.HTML (HTML, Node, div)
import Util.Proxy.Dictionary.Color (color_)
import Util.Style.Style (borderRadiusPct50, class_, displayInlineBlock, heightRem, inferAnimationId, refineClass, reflectStaticClass, transparent, widthRem, (.?))

staticClass :: String
staticClass = reflectStaticClass ι

classWithColor :: Color -> String
classWithColor color = refineClass staticClass color_ $ show color

animationId :: String
animationId = inferAnimationId staticClass

style :: Color -> CSS.CSS
style color = do
  staticClass .? do
    widthRem 3.0
    heightRem 3.0
    borderRadiusPct50
    displayInlineBlock
    borderRight solid (rem 0.4) transparent
    boxSizing borderBox

    CSS.animation 
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

animation :: ∀ w i. Node HTMLdiv w i
animation props = div ([ class_ staticClass ] <> props)

animation_ :: ∀ w i. Array (HTML w i) -> HTML w i
animation_ = animation []