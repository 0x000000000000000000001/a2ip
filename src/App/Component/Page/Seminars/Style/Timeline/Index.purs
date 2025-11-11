module App.Component.Page.Seminars.Style.Timeline.Index
  ( style
  ) where

import Proem hiding (top)

import App.Component.Page.Seminars.Style.Timeline.Timeline as Timeline
import App.Component.Page.Seminars.Style.Timeline.Label.Index as Label
import CSS as CSS

style :: CSS.CSS
style = do
  Timeline.style
  Label.style