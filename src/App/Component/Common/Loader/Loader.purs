module App.Component.Common.Loader.Loader
  ( loader
  ) where

import Proem hiding (div)

import App.Component.Common.Loader.Style.Loader (classId)
import App.Component.Common.Loader.Style.Sheet (sheet)
import App.Util.Capability.AppM (AppM)
import CSS (Color)
import Halogen (ComponentHTML)
import Halogen.HTML (div)
import Util.Style (class_)

loader :: ∀ action slots. Color -> ComponentHTML action slots AppM
loader color = div [ class_ classId ] [ sheet color ]
  