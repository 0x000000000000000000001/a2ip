module App.Component.Common.Loader.Loader
  ( loader
  ) where

import Proem hiding (div)

import App.Component.Common.Loader.Type (Input)
import App.Component.Common.Loader.Style.Animation as Animation
import App.Component.Common.Loader.Style.Loader (classId)
import App.Component.Common.Loader.Style.Sheet (sheet)
import App.Util.Capability.AppM (AppM)
import Halogen (ComponentHTML)
import Halogen.HTML (div)
import Util.Style.Style (class_, classes)

loader :: ∀ action slots. Input -> ComponentHTML action slots AppM
loader color = 
  div 
    [ class_ classId ] 
    [ sheet color 
    , div [ classes [ Animation.classId, Animation.classIdWithColor color ] ] []
    ]
  