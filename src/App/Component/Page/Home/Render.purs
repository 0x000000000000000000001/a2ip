module App.Component.Page.Home.Render
  ( render
  ) where

import Proem hiding (div)

import App.Component.Common.Carrousel.Component as Carrousel
import App.Component.Common.Carrousel.Type (Media(..))
import App.Component.Common.Modal.Component (modal)
import App.Component.Page.Home.HandleModalOutput (handleModalOutput)
import App.Component.Page.Home.Type (Action(..), Slots, State)
import App.Component.Util.Type (noSlotAddressIndex)
import App.Util.Capability.AppM (AppM)
import Data.Maybe (Maybe(..))
import Halogen (ComponentHTML)
import Halogen.HTML (div, div_, text)
import Halogen.HTML.Events (onClick)
import Util.File.Image.Common (ourImageRelativePath)
import Util.Proxy.Dictionary.Modal (modal')

render :: State -> ComponentHTML Action Slots AppM
render { showModal } =
  div_
    [ div
        [ onClick $ κ $ ShowModal ]
        [ text $ "modal: " <> (showModal ? "visible" ↔ "hidden") ]
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
                ]
            }
        }
        handleModalOutput
    ]