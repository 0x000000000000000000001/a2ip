module App.Component.Common.Tooltip.Tooltip
  ( tooltip
  )
  where

import App.Component.Common.Tooltip.Style.Sheet (sheet)
import App.Component.Common.Tooltip.Style.Tooltip (classId)
import App.Component.Common.Tooltip.Type (Input)
import App.Util.Capability.AppM (AppM)
import Halogen (ComponentHTML)
import Halogen.HTML (div)
import Util.Style (class_)

tooltip 
  :: ∀ action slots
   . Input action slots
  -> ComponentHTML action slots AppM
tooltip { inner, outer } = 
  div 
    [ class_ classId ]
    [ sheet
    , inner
    , outer
    ]