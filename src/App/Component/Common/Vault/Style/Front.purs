module App.Component.Common.Vault.Style.Front
  ( animationDurationMs
  , staticClass
  , staticClassWhen
  , staticClassWhenIncorrect
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
import Util.Proxy.Dictionary.Phase (phase_)
import Util.Style.Style (alignItemsCenter, displayFlex, heightPct100, inferAnimationId, justifyContentCenter, leftPct, limegreen, nothing, overflowHidden, placeholder, pointerEventsNone, positionRelative, red, refineClass, refineClass', reflectStaticClass, rightPct, topLeftToTopLeft, transparent, widthPct100, (.&.), (.?), (.|*.), (:&:), (:?), (:|*.), (:|*:), (|*.))

staticClass :: String
staticClass = reflectStaticClass ι

staticClassWhen :: Phase -> String
staticClassWhen phase = refineClass staticClass phase_ $ show phase

staticClassWhenIncorrect :: String
staticClassWhenIncorrect = refineClass' staticClass incorrect_ 

lockAnimationId :: String
lockAnimationId = inferAnimationId staticClass

animationDurationMs :: Number
animationDurationMs = 300.0

style :: CSS.CSS
style = do
  staticClass .? do
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
  __input = staticClass .|*. Input.staticClass
  ____field = __input :|*. Field.staticClass
  ______placeholder = ____field :&: placeholder
  ____label = __input :|*. Label.staticClass
  __unlocking = staticClass .&. staticClassWhen Unlocking
  a___lock = __unlocking :|*. Lock.staticClass
  a___message = __unlocking :|*. Message.staticClass
  a___input = __unlocking :|*. Input.staticClass
  __unlocked = staticClass .&. staticClassWhen Unlocked
  b___message = __unlocked :|*. Message.staticClass
  b___input = __unlocked :|*. Input.staticClass
  ____leftDoor = __unlocked |*. Door.staticClassWhenLeft
  ____rightDoor = __unlocked |*. Door.staticClassWhenRight
  b___lock = __unlocked |*. Lock.staticClass
  __incorrect = staticClass .&. staticClassWhenIncorrect
  c___lock = __incorrect :|*. Lock.staticClass
  c___message = __incorrect :|*. Message.staticClass
  ______strong = c___message :|*: strong
