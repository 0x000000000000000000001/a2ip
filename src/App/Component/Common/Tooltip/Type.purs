module App.Component.Common.Tooltip.Type where

import App.Util.Capability.AppM (AppM)
import CSS as CSS
import Halogen (ComponentHTML)
import Halogen.HTML (text)
import Util.Style (nothing)

type Input action slots = 
    { inner :: ComponentHTML action slots AppM
    , outer :: ComponentHTML action slots AppM
    , outerOffset :: Number
    , outerStyle :: CSS.CSS
    }

defaultInput :: ∀ action slots. Input action slots
defaultInput = 
    { inner: text ""
    , outer: text ""
    , outerOffset: 1.0
    , outerStyle: nothing
    }
