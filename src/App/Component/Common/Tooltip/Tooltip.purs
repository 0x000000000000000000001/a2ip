module App.Component.Common.Tooltip.Tooltip
  ( tooltip
  )
  where

import Proem (discard)
import App.Component.Common.Tooltip.Style.Inner as Inner
import App.Component.Common.Tooltip.Style.Outer.Core as Core
import App.Component.Common.Tooltip.Style.Outer.Outer as Outer
import App.Component.Common.Tooltip.Style.Sheet (sheet)
import App.Component.Common.Tooltip.Style.Tooltip (classId)
import App.Component.Common.Tooltip.Type (Input)
import App.Util.Capability.AppM (AppM)
import Halogen (ComponentHTML)
import Halogen.HTML (div)
import Halogen.HTML.CSS (style)
import Util.Style (class_, padding1)

tooltip 
  :: ∀ action slots
   . Input action slots
  -> ComponentHTML action slots AppM
tooltip { inner, outer, outerOffset, outerStyle } = 
  div 
    [ class_ classId ]
    [ sheet
    , div 
        [ class_ Inner.classId ]
        [ inner ]
    , div 
        [ class_ Outer.classId
        , style do 
            padding1 outerOffset
            outerStyle
        ]
        [ div 
            [ class_ Core.classId ]
            [ outer ]
        ]
    ]