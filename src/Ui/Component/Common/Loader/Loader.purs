module Ui.Component.Common.Loader.Loader
  ( loader
  ) where

import Proem hiding (div)

import Ui.Component.Common.Loader.Style.Animation (animation_)
import Ui.Component.Common.Loader.Style.Loader (loader_)
import Ui.Component.Common.Loader.Style.Sheet (sheet)
import Ui.Component.Common.Loader.Type (Input)
import Ui.Util.Capability.AppM (AppM)
import Halogen (ComponentHTML)

loader :: ∀ action slots. Input -> ComponentHTML action slots AppM
loader color = 
  loader_
    [ sheet color 
    , animation_ color
    ]
  