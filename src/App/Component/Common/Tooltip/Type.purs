module App.Component.Common.Tooltip.Type where

import App.Util.Capability.AppM (AppM)
import Halogen (ComponentHTML)
import Util.Style (Position)

type Input action slots = 
    { inner :: ComponentHTML action slots AppM
    , outer :: ComponentHTML action slots AppM
    , outerPosition :: Position
    }
