module Ui.Component.Common.Tooltip.Type where

import Ui.Util.Capability.AppM (AppM)
import Data.Maybe (Maybe(..))
import Halogen (ComponentHTML)
import Halogen.HTML (text)

type Style = 
    { offset :: Maybe Number
    }

type Input action slots = 
    { disabled :: Boolean
    , inner :: ComponentHTML action slots AppM
    , outer :: ComponentHTML action slots AppM
    , style :: Style
    }

defaultInput :: ∀ action slots. Input action slots
defaultInput = 
    { disabled: false
    , inner: text ""
    , outer: text ""
    , style: 
        { offset: Nothing
        }
    }
