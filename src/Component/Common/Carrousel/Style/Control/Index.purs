module Component.Common.Carrousel.Style.Control.Index
  ( style
  ) where

import CSS as CSS
import Component.Common.Carrousel.Style.Control.Control as Control
import Component.Common.Carrousel.Style.Control.Icon as Icon
import Prelude (discard)

style :: CSS.CSS
style = do
  Control.style 
  Icon.style 