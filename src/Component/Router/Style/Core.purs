module Component.Router.Style.Core
  ( classId
  , style
  ) where

import Prelude hiding (top)

import CSS (angular, animation, background, backgroundColor, backgroundPosition, backgroundSize, body, borderRadius, by, darken, deg, desaturate, display, ease, flex, flexGrow, fontFamily, forwards, fromString, infinite, keyframes, lighten, linearGradient, normalAnimationDirection, pct, positioned, rem, sansSerif, saturate, sec, star, (?))
import CSS as CSS
import CSS.Overflow (overflow)
import CSS.Overflow as Overflow
import Component.Router.Menu.Style.Menu as MenuStyle
import Data.NonEmpty ((:|))
import Data.Tuple (Tuple(..))
import Data.Tuple.Nested ((/\))
import Utils.Style (backgroundWhite, margin, padding, raw, red, (<?))

classId :: String
classId = "MvOJiB63k"

bodyGradientAnimationId :: String
bodyGradientAnimationId = "yw65DgoVL"

style :: CSS.CSS
style = do
  star ? do
    raw "transition" "all 0.3s ease"
    fontFamily [ "Open Sans" ] (sansSerif :| [])

  keyframes bodyGradientAnimationId $ (
    0.0 /\ backgroundPosition (positioned (pct 0.0) (pct 50.0))
    :| [ 50.0 /\ backgroundPosition (positioned (pct 100.0) (pct 50.0))
       , 100.0 /\ backgroundPosition (positioned (pct 0.0) (pct 50.0))
       ]
  )

  body ? do 
    margin 0.0
    padding 0.0
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

  classId <? do
    CSS.margin (rem 2.0) (rem 2.0) (rem 2.0) (rem $ 2.0 + MenuStyle.foldWidth)
    display flex
    backgroundColor backgroundWhite
    padding 1.0
    borderRadius (rem 0.6) (rem 0.6) (rem 0.6) (rem 0.6)
    overflow Overflow.hidden
    flexGrow 1.0