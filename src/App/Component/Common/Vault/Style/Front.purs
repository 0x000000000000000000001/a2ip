module App.Component.Common.Vault.Style.Front
  ( classId
  , classIdWhen
  , style
  )
  where

import Proem hiding (top)

import App.Component.Common.Input.Style.Field as Field
import App.Component.Common.Input.Style.Input as Input
import App.Component.Common.Input.Style.Label as Label
import App.Component.Common.Vault.Style.Message as Message
import App.Component.Common.Vault.Type (Phase(..))
import CSS (animation, backgroundColor, borderBottom, color, column, darken, deg, flexDirection, forwards, fromString, iterationCount, keyframes, linear, normalAnimationDirection, opacity, outline, rem, rgba, rotate, sec, solid, transforms, visibility, white, zIndex)
import CSS as CSS
import CSS.Common (hidden)
import CSS.Transform (scale)
import Data.NonEmpty ((:|))
import Data.Tuple.Nested ((/\))
import Util.Style (alignItemsCenter, displayFlex, hash9, heightPct100, heightRem, justifyContentCenter, margin1, nothing, overflowHidden, placeholder, positionRelative, svg, topLeftToTopLeft, transparent, widthPct100, widthRem, (.&.), (.?), (.|*.), (.|*:), (:&:), (:?), (:|*.), (:|*:))

classId :: String
classId = "j8djWsw23"

classIdWhen :: Phase -> String
classIdWhen phase = hash9 $ classId <> "-" <> show phase

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
    overflowHidden

  __svg :? do 
    widthRem 8.0
    heightRem 8.0
    margin1 1.2
    opacity 0.9

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

  a___input :? do 
    opacity 0.0
    visibility hidden

  __unlocked :? do 
    nothing 

  b___input :? do 
      opacity 0.0
      visibility hidden

  ____message :? do 
    visibility hidden

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
  __unlocking = classId .&. classIdWhen Unlocking
  ____svg = __unlocking :|*: svg
  a___input = __unlocking :|*. Input.classId
  __unlocked = classId .&. classIdWhen Unlocked
  ____message = __unlocked :|*. Message.classId
  b___input = __unlocked :|*. Input.classId
