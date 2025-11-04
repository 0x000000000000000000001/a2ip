module App.Component.Common.Vault.Style.Front
  ( classId
  , classIdWhenUnlocking
  , style
  )
  where

import Proem hiding (top)

import App.Component.Common.Input.Style.Field as Field
import App.Component.Common.Input.Style.Input as Input
import App.Component.Common.Input.Style.Label as Label
import CSS (animation, backgroundColor, borderBottom, color, column, darken, deg, flexDirection, forwards, fromString, iterationCount, keyframes, linear, normalAnimationDirection, opacity, outline, rem, rgba, rotate, sec, solid, transforms, white, zIndex)
import CSS as CSS
import CSS.Transform (scale)
import Data.NonEmpty ((:|))
import Data.Tuple.Nested ((/\))
import Util.Style (alignItemsCenter, displayFlex, heightPct100, heightRem, justifyContentCenter, margin1, nothing, placeholder, positionRelative, svg, topLeftToTopLeft, transparent, widthPct100, widthRem, (.&.), (.?), (.|*.), (.|*:), (:&:), (:?), (:|*.), (:|*:))

classId :: String
classId = "j8djWsw23"

classIdWhenUnlocking :: String
classIdWhenUnlocking = "ZESffOk57"

animationId :: String
animationId = "XfIdRyd3W"

style :: CSS.CSS
style = do
  classId .? do
    positionRelative
    topLeftToTopLeft
    zIndex 2
    backgroundColor $ rgba 0 0 0 0.75
    widthPct100
    heightPct100
    displayFlex
    justifyContentCenter
    alignItemsCenter
    flexDirection column

  __svg :? do 
    widthRem 8.0
    heightRem 8.0
    margin1 1.2
    opacity 0.9

  __unlocking :? do 
    nothing

  ____svg :? do 
    animation
      (fromString animationId) 
      (sec 0.75)
      linear
      (sec 0.0)
      (iterationCount 1.0)
      normalAnimationDirection
      forwards

  __input :? do
    nothing

  ____field :? do 
    outline solid (rem 0.2) white
    borderBottom solid (rem 0.0) white
    backgroundColor transparent
    color white

  ______placeholder :? do
    color $ darken 0.24 white

  ____label :? do
    color white

  keyframes animationId (
    ( 0.0 /\ transforms [ rotate $ deg 0.0 ]
    ) :| 
    [ 90.0 /\ transforms [ rotate $ deg $ -180.0 ]
    , 100.0 /\ transforms [ rotate $ deg $ -180.0, scale 1.1 1.1 ]
    ]
  )

  where 
  __svg = classId .|*: svg
  __input = classId .|*. Input.classId
  ____field = __input :|*. Field.classId
  ______placeholder = ____field :&: placeholder
  ____label = __input :|*. Label.classId
  __unlocking = classId .&. classIdWhenUnlocking
  ____svg = __unlocking :|*: svg
