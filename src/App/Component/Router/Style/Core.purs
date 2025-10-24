module App.Component.Router.Style.Core
  ( animationDurationMs
  , classId
  , style
  )
  where

import Proem hiding (top)

import App.Component.Router.Menu.Style.Menu as MenuStyle
import CSS (angular, animation, background, backgroundColor, backgroundPosition, backgroundSize, body, by, darken, deg, desaturate, ease, fontFamily, forwards, fromString, hover, html, infinite, keyframes, lighten, linearGradient, normalAnimationDirection, pct, positioned, rgba, sansSerif, saturate, sec, star)
import CSS as CSS
import Data.NonEmpty ((:|))
import Data.Tuple (Tuple(..))
import Data.Tuple.Nested ((/\))
import Util.Style (backgroundColorWhite, borderRadius1, displayFlex, flexGrow1, heightRem, margin1, margin4, padding1, raw, red, widthRem, (.?), (:&:), (:?))

classId :: String
classId = "MvOJiB63k"

bodyGradientAnimationId :: String
bodyGradientAnimationId = "yw65DgoVL"

animationDurationMs :: Number
animationDurationMs = 300.0

style :: CSS.CSS
style = do
  classId .? do
    margin4 2.0 2.0 2.0 $ 2.0 + MenuStyle.foldWidth
    displayFlex
    backgroundColorWhite
    padding1 1.0
    borderRadius1 0.6
    flexGrow1

  html :? do 
    raw "scroll-behavior" "smooth"
    raw "-webkit-overflow-scrolling" "touch"

  star :? do
    raw "transition" $ "all " <> show animationDurationMs <> "ms ease"
    fontFamily [] (sansSerif :| [])

    raw "scrollbar-width" "thin"
    raw "scrollbar-color" "rgba(0, 0, 0, 0.3) rgba(0, 0, 0, 0.05)"

  __webkitScrollbar :? do
    widthRem 0.5
    heightRem 0.5

  __webkitScrollbarTrack :? do
    backgroundColor $ rgba 0 0 0 0.05

  __webkitScrollbarThumb :? do
    backgroundColor $ rgba 0 0 0 0.3
    borderRadius1 0.25

  __webkitScrollbarThumbHover :? do
    backgroundColor $ rgba 0 0 0 0.5

  __webkitScrollbarCorner :? do
    backgroundColor $ rgba 0 0 0 0.05

  keyframes bodyGradientAnimationId $ (
    0.0 /\ backgroundPosition (positioned (pct 0.0) (pct 50.0))
    :| [ 50.0 /\ backgroundPosition (positioned (pct 100.0) (pct 50.0))
       , 100.0 /\ backgroundPosition (positioned (pct 0.0) (pct 50.0))
       ]
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
  __webkitScrollbar = star :&: fromString "::-webkit-scrollbar"
  __webkitScrollbarTrack = star :&: fromString "::-webkit-scrollbar-track"
  __webkitScrollbarThumb = star :&: fromString "::-webkit-scrollbar-thumb"
  __webkitScrollbarThumbHover = __webkitScrollbarThumb :&: hover
  __webkitScrollbarCorner = star :&: fromString "::-webkit-scrollbar-corner"
