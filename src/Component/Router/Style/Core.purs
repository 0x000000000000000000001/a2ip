module Component.Router.Style.Core
  ( classId
  , style
  ) where

import Proem hiding (top)

import CSS (angular, animation, background, backgroundPosition, backgroundSize, body, by, darken, deg, desaturate, ease, fontFamily, forwards, fromString, infinite, keyframes, lighten, linearGradient, normalAnimationDirection, pct, positioned, sansSerif, saturate, sec, star, (?))
import CSS as CSS
import Component.Router.Menu.Style.Menu as MenuStyle
import Data.NonEmpty ((:|))
import Data.Tuple (Tuple(..))
import Data.Tuple.Nested ((/\))
import Util.Style (backgroundColorWhite, borderRadius1, displayFlex, flexGrow1, margin1, margin4, overflowHidden, padding1, raw, red, (.?))

classId :: String
classId = "MvOJiB63k"

bodyGradientAnimationId :: String
bodyGradientAnimationId = "yw65DgoVL"

style :: CSS.CSS
style = do
  classId .? do
    margin4 2.0 2.0 2.0 $ 2.0 + MenuStyle.foldWidth
    displayFlex
    backgroundColorWhite
    padding1 1.0
    borderRadius1 0.6
    overflowHidden 
    flexGrow1

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