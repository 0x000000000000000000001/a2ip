module App.Component.Common.Loader.Loader
  ( loader
  ) where

import Proem hiding (div)

import App.Component.Common.Loader.Style.Animation (animation_)
import App.Component.Common.Loader.Style.Loader (loader_)
import App.Component.Common.Loader.Style.Sheet (sheet)
import App.Component.Common.Loader.Type (Input)
import App.Util.Capability.AppM (AppM)
import Halogen (ComponentHTML)

loader :: ∀ action slots. Input -> ComponentHTML action slots AppM
loader color = 
  loader_
    [ sheet color 
    , animation_ color
    ]
  