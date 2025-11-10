module App.Component.Common.Tooltip.Tooltip
  ( tooltip
  )
  where

import Proem hiding (div)

import App.Component.Common.Tooltip.Style.Inner as Inner
import App.Component.Common.Tooltip.Style.Outer.Core as Core
import App.Component.Common.Tooltip.Style.Outer.Outer as Outer
import App.Component.Common.Tooltip.Style.Sheet (sheet)
import App.Component.Common.Tooltip.Style.Tooltip (staticClass)
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
  div 
    [ class_ staticClass ]
    [ sheet
    , div 
        [ class_ Inner.staticClass ]
        [ inner ]
    , disabled 
        ? noHtml 
        ↔ div 
            [ class_ Outer.staticClass 
            , style do 
                padding1 $ offset ??⇒ 1.0
            ]
            [ div 
                [ class_ Core.staticClass ]
                [ outer ]
            ]
    ]