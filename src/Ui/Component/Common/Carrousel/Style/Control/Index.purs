module Ui.Component.Common.Carrousel.Style.Control.Index
  ( style
  ) where

import Proem (discard)
import CSS as CSS
import Ui.Component.Common.Carrousel.Style.Control.Control as Control
import Ui.Component.Common.Carrousel.Style.Control.Icon as Icon

style :: CSS.CSS
style = do
  Control.style 
  Icon.style 