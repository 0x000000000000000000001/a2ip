module App.Component.Common.Timeline.Style.DownArrow
  ( classId
  , style
  )
  where

import Proem hiding (top)

import App.Component.Common.Timeline.Style.Util (grey)
import CSS as CSS
import Util.Style (fill, nothing, (.?))

classId :: String
classId = "Gnkn8ajS5"

style :: CSS.CSS
style = do
  classId .? do
    nothing
    fill grey