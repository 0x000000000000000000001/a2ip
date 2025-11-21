module Ui.Component.Common.Tooltip.Tooltip
  ( tooltip
  )
  where

import Proem hiding (div)

import Ui.Component.Common.Tooltip.Style.Inner (inner_)
import Ui.Component.Common.Tooltip.Style.Outer.Core (core_)
import Ui.Component.Common.Tooltip.Style.Outer.Outer (outer)
import Ui.Component.Common.Tooltip.Style.Sheet (sheet)
import Ui.Component.Common.Tooltip.Style.Tooltip (tooltip_)
import Ui.Component.Common.Tooltip.Type (Input)
import Ui.Component.Util.Type (noHtml)
import Ui.Util.Capability.AppM (AppM)
import Halogen (ComponentHTML)
import Halogen.HTML.CSS (style)
import Util.Style.Style (padding1)

tooltip 
  :: ∀ action slots
   . Input action slots
  -> ComponentHTML action slots AppM
tooltip { disabled, inner, outer: outer', style: { offset } } = 
  tooltip_
    [ sheet
    , inner_ [ inner ]
    , disabled 
        ? noHtml 
        ↔ outer 
            [ style do 
                padding1 $ offset ??⇒ 1.0
            ]
            [ core_ [ outer' ] ]
    ]