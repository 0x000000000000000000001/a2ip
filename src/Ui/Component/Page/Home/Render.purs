module Ui.Component.Page.Home.Render
  ( render
  ) where

import Proem hiding (div)

import Ui.Component.Common.Carrousel.Component as Carrousel
import Ui.Component.Common.Carrousel.Type (Media(..))
import Ui.Component.Common.Modal.Component (modal)
import Ui.Component.Common.Tooltip.Tooltip (tooltip)
import Ui.Component.Common.Tooltip.Type (defaultInput)
import Ui.Component.Page.Home.HandleModalOutput (handleModalOutput)
import Ui.Component.Page.Home.Type (Action(..), Slots, State)
import Ui.Component.Util.Type (noSlotAddressIndex)
import Ui.Util.Capability.AppM (AppM)
import Data.Maybe (Maybe(..))
import Halogen (ComponentHTML)
import Halogen.HTML (div, div_, text)
import Halogen.HTML.Events (onClick)
import Util.File.Image.Common (ourImageRelativePath)
import Util.Proxy.Dictionary.Modal (modal')

render :: State -> ComponentHTML Action Slots AppM
render { showModal, innerClicks, outerClicks } =
  div_
    [ div_
        [ text $ "Inner clicks: " <> show innerClicks
        , text " | "
        , text $ "Outer clicks: " <> show outerClicks
        ]
    , tooltip
        defaultInput 
          { inner =
              div
                [ onClick $ κ $ InnerClicked ]
                [ text $ "Modal: " <> (showModal ? "visible" ↔ "hidden") ]
          , outer = 
              div
                [ onClick $ κ $ OuterClicked ]
                [ text "Click me too (outer)" ]
          }
    , modal
        Carrousel.component
        modal'
        noSlotAddressIndex
        { closable: true
        , open: showModal
        , innerInput:
            { slides:
                [ { media: Image $ ourImageRelativePath "component/page" "kevin-francart"
                  , caption: Just "Kevin Francart"
                  }
                , { media: YoutubeVideo $ "https://www.youtube.com/watch?v=dQw4w9WgXcQ"
                  , caption: Just "Super émission CCA !"
                  }
                , { media: Image $ ourImageRelativePath "component/page" "ellen-corin"
                  , caption: Nothing
                  }
                , { media: Image $ ourImageRelativePath "component/page" "ellen-corin2222"
                  , caption: Nothing
                  }
                ]
            }
        }
        handleModalOutput
    ]