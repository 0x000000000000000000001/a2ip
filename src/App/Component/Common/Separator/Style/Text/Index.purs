module App.Component.Common.Separator.Style.Text.Index
  ( style
  )
  where

import Proem

import CSS as CSS
import App.Component.Common.Separator.Style.Text.Sofa as Sofa
import App.Component.Common.Separator.Style.Text.Text as Text

style :: CSS.CSS
style = do
  Text.style
  Sofa.style