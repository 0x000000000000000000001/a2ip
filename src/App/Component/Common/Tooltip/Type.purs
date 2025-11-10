module App.Component.Common.Tooltip.Type where

import App.Component.Util.Type (Size)
import App.Util.Capability.AppM (AppM)
import Data.Maybe (Maybe(..))
import Halogen (ComponentHTML)
import Halogen.HTML (text)

type Style = 
    { minWidth :: Maybe Size
    }

type Input action slots = 
    { inner :: ComponentHTML action slots AppM
    , outer :: ComponentHTML action slots AppM
    , outerOffset :: Number
    , style :: Style
    }

defaultInput :: ∀ action slots. Input action slots
defaultInput = 
    { inner: text ""
    , outer: text ""
    , outerOffset: 1.0
    , style: 
        { minWidth: Nothing
        }
    }
