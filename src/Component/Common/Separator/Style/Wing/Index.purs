module Component.Common.Separator.Style.Wing.Index
  ( style
  )
  where

import Proem

import CSS as CSS
import Component.Common.Separator.Style.Wing.End as End
import Component.Common.Separator.Style.Wing.Wing as Wing

style :: CSS.CSS
style = do
  End.style
  Wing.style