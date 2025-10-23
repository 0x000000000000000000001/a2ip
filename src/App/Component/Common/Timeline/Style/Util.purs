module App.Component.Common.Timeline.Style.Util
  ( grey
  )
  where

import Proem hiding (top)

import Color (Color, darken)
import Util.Style (loadingGrey)

grey :: Color
grey = darken 0.2 loadingGrey