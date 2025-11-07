module App.Component.Common.PrettyErrorImage.Style.QuestionMark
  ( statelessClass
  , style
  ) where

import Proem hiding (top)

import CSS (darken)
import CSS as CSS
import Util.Style (fill, reflectHashModuleName, loadingGrey, widthRem, (.?))

statelessClass :: String
statelessClass = reflectHashModuleName ι

style :: CSS.CSS
style = do
  statelessClass .? do
    widthRem 3.0
    fill $ darken 0.4 loadingGrey