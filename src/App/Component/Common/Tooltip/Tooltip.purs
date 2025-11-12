module App.Component.Common.Tooltip.Tooltip
  ( tooltip
  )
  where

import Proem hiding (div)

import App.Component.Common.Tooltip.Style.Inner (inner_)
import App.Component.Common.Tooltip.Style.Inner as Inner
import App.Component.Common.Tooltip.Style.Outer.Core (core_)
import App.Component.Common.Tooltip.Style.Outer.Core as Core
import App.Component.Common.Tooltip.Style.Outer.Outer (outer)
import App.Component.Common.Tooltip.Style.Outer.Outer as Outer
import App.Component.Common.Tooltip.Style.Sheet (sheet)
import App.Component.Common.Tooltip.Style.Tooltip (staticClass, tooltip_)
import App.Component.Common.Tooltip.Type (Input)
import App.Component.Util.Type (noHtml)
import App.Util.Capability.AppM (AppM)
import Halogen (ComponentHTML)
import Halogen.HTML (div)
import Halogen.HTML.CSS (style)
import Util.Style.Style (class_, padding1)

tooltip 
  :: ∀ action slots
   . Input action slots
  -> ComponentHTML action slots AppM
tooltip { disabled, inner, outer, style: { offset } } = 
  tooltip_
    [ sheet
    , inner_ [ inner ]
    , disabled 
        ? noHtml 
        ↔ outer 
            [ style do 
                padding1 $ offset ??⇒ 1.0
            ]
            [ core_ [ outer ] ]
    ]