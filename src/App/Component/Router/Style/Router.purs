module App.Component.Router.Style.Router
  ( animationDurationMs
  , bodyGradientAnimationId
  , classId
  , style
  )
  where

import Proem hiding (top)

import CSS (angular, animation, background, backgroundColor, backgroundPosition, backgroundSize, body, by, darken, deg, desaturate, ease, fontFamily, forwards, fromString, hover, html, infinite, keyframes, lighten, linearGradient, minHeight, normalAnimationDirection, pct, positioned, rem, rgba, sansSerif, saturate, sec, vh)
import CSS as CSS
import Data.NonEmpty ((:|))
import Data.Tuple (Tuple(..))
import Data.Tuple.Nested ((/\))
import Util.Style (all, borderRadiusRem1, displayFlex, heightRem, loadingShimmerAnimationId, loadingShimmerWidth, margin1, padding1, raw, red, widthRem, (.?), (:&:), (:?))

classId :: String
classId = "DDGK8gCXg"

bodyGradientAnimationId :: String
bodyGradientAnimationId = "yw65DgoVL"

animationDurationMs :: Number
animationDurationMs = 300.0

style :: CSS.CSS
style = do
  classId .? do
    displayFlex
    minHeight (vh 100.0)

  html :? do 
    -- Momentum scrolling scrolling on iOS or Safari
    raw "-webkit-overflow-scrolling" "touch"

  all :? do
    raw "transition" $ "all " <> show animationDurationMs <> "ms ease"
    fontFamily [] (sansSerif :| [])

    -- Firefox
    raw "scrollbar-width" "thin"
    raw "scrollbar-color" "rgba(0, 0, 0, 0.3) rgba(0, 0, 0, 0.05)"

    -- Chrome/Safari/Edge/...
  __webkitScrollbar :? do
    widthRem 0.5
    heightRem 0.5

  __webkitScrollbarTrack :? do
    backgroundColor $ rgba 0 0 0 0.05

  __webkitScrollbarThumb :? do
    backgroundColor $ rgba 0 0 0 0.3
    borderRadiusRem1 0.25

  __webkitScrollbarThumbHover :? do
    backgroundColor $ rgba 0 0 0 0.5

  __webkitScrollbarCorner :? do
    backgroundColor $ rgba 0 0 0 0.05

  keyframes bodyGradientAnimationId (
    0.0 /\ backgroundPosition (positioned (pct 0.0) (pct 50.0))
    :| [ 50.0 /\ backgroundPosition (positioned (pct 100.0) (pct 50.0))
       , 100.0 /\ backgroundPosition (positioned (pct 0.0) (pct 50.0))
       ]
  )

  keyframes loadingShimmerAnimationId (
    0.0 /\ backgroundPosition (positioned (rem $ -1.0 * loadingShimmerWidth) (rem 0.0))
    :| [ 100.0 /\ (raw "background-position" $ "calc(100% + " <> show loadingShimmerWidth <> "rem) 0") ]
  )

  body :? do
    margin1 0.0
    padding1 0.0
    background $ linearGradient (angular $ deg $ -45.0) [
      Tuple (saturate 0.1 $ darken 0.1 red) (pct 25.0),
      Tuple red (pct 50.0),
      Tuple (desaturate 0.1 $ lighten 0.2 red) (pct 75.0)
    ]
    backgroundSize $ by (pct 400.0) (pct 400.0)
    animation 
      (fromString bodyGradientAnimationId) 
      (sec 15.0)
      ease
      (sec 0.0)
      infinite
      normalAnimationDirection
      forwards

  where 
  __webkitScrollbar = all :&: fromString "::-webkit-scrollbar"
  __webkitScrollbarTrack = all :&: fromString "::-webkit-scrollbar-track"
  __webkitScrollbarThumb = all :&: fromString "::-webkit-scrollbar-thumb"
  __webkitScrollbarThumbHover = __webkitScrollbarThumb :&: hover
  __webkitScrollbarCorner = all :&: fromString "::-webkit-scrollbar-corner"