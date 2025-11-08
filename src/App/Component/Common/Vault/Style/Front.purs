module App.Component.Common.Vault.Style.Front
  ( animationDurationMs
  , classId
  , classIdWhen
  , classIdWhenIncorrect
  , style
  )
  where

import Proem hiding (top)

import App.Component.Common.Input.Style.Field as Field
import App.Component.Common.Input.Style.Input as Input
import App.Component.Common.Input.Style.Label as Label
import App.Component.Common.Vault.Style.Door as Door
import App.Component.Common.Vault.Style.Lock as Lock
import App.Component.Common.Vault.Style.Message as Message
import App.Component.Common.Vault.Type (Phase(..))
import CSS (animation, backgroundColor, borderBottom, color, column, darken, deg, flexDirection, forwards, fromString, iterationCount, keyframes, lighten, linear, marginLeft, normalAnimationDirection, opacity, outline, pct, rem, rotate, sec, solid, strong, transforms, white, zIndex)
import CSS as CSS
import CSS.Transform (scale)
import Data.NonEmpty ((:|))
import Data.Tuple.Nested ((/\))
import Util.Proxy.Dictionary.Incorrect (incorrect_)
import Util.Style.Style (alignItemsCenter, displayFlex, heightPct100, justifyContentCenter, leftPct, limegreen, nothing, overflowHidden, placeholder, pointerEventsNone, positionRelative, red, inferStatefulClass, reflectStatelessClass, rightPct, topLeftToTopLeft, transparent, widthPct100, (.&.), (.?), (.|*.), (:&:), (:?), (:|*.), (:|*:), (|*.))

classId :: String
classId = reflectStatelessClass ι

classIdWhen :: Phase -> String
classIdWhen phase = inferStatefulClass classId $ show phase

classIdWhenIncorrect :: String
classIdWhenIncorrect = inferStatefulClass classId incorrect_

lockAnimationId :: String
lockAnimationId = inferStatefulClass classId "lockAnimation"

animationDurationMs :: Number
animationDurationMs = 300.0

style :: CSS.CSS
style = do
  classId .? do
    topLeftToTopLeft
    zIndex 3
    widthPct100
    heightPct100
    displayFlex
    justifyContentCenter
    alignItemsCenter
    flexDirection column
    overflowHidden

  __input :? do
    positionRelative
    zIndex 5

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

  a___message :? do 
    opacity 0.0

  a___lock :? do
    outline solid (rem 0.3) limegreen
    animation
      (fromString lockAnimationId) 
      (sec $ animationDurationMs / 1000.0)
      linear
      (sec 0.0)
      (iterationCount 1.0)
      normalAnimationDirection
      forwards

  a___input :? do 
    opacity 0.0
    pointerEventsNone

  __unlocked :? do 
    zIndex 1

  b___input :? do 
      opacity 0.0
      pointerEventsNone

  b___message :? do 
    opacity 0.0

  ____leftDoor :? do 
    leftPct $ -50.0

  ____rightDoor :? do 
    rightPct $ -50.0

  b___lock :? do
    marginLeft (pct 100.0)
    opacity 0.0

  __incorrect :? do 
    nothing

  c___lock :? do 
    outline solid (rem 0.3) red

  c___message :? do 
    nothing

  ______strong :? do 
    color $ lighten 0.2 red

  keyframes lockAnimationId (
    ( 0.0 /\ transforms [ rotate $ deg 0.0 ]
    ) :| 
    [ 90.0 /\ transforms [ rotate $ deg $ -180.0 ]
    , 100.0 /\ transforms [ rotate $ deg $ -180.0, scale 1.11 1.11 ]
    ]
  )

  where 
  __input = classId .|*. Input.classId
  ____field = __input :|*. Field.classId
  ______placeholder = ____field :&: placeholder
  ____label = __input :|*. Label.classId
  __unlocking = classId .&. classIdWhen Unlocking
  a___lock = __unlocking :|*. Lock.classId
  a___message = __unlocking :|*. Message.classId
  a___input = __unlocking :|*. Input.classId
  __unlocked = classId .&. classIdWhen Unlocked
  b___message = __unlocked :|*. Message.classId
  b___input = __unlocked :|*. Input.classId
  ____leftDoor = __unlocked |*. Door.classIdWhenLeft
  ____rightDoor = __unlocked |*. Door.classIdWhenRight
  b___lock = __unlocked |*. Lock.classId
  __incorrect = classId .&. classIdWhenIncorrect
  c___lock = __incorrect :|*. Lock.classId
  c___message = __incorrect :|*. Message.classId
  ______strong = c___message :|*: strong
