module Component.Common.Separator.Style.Util
  ( grey
  )
  where

import Proem hiding (top)

import CSS (darken)
import Color (Color)
import Util.Style (loadingGrey)

grey :: Color
grey = darken 0.1 loadingGrey