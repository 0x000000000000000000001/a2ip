module App.Component.Common.Tooltip.Style.Outer.Index
  ( style
  ) where

import Proem (discard)
import App.Component.Common.Tooltip.Style.Outer.Core as Core
import App.Component.Common.Tooltip.Style.Outer.Outer as Outer
import CSS as CSS

style :: CSS.CSS
style = do
  Core.style 
  Outer.style