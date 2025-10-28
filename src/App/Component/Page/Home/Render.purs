module App.Component.Page.Home.Render
  ( render
  ) where

import Proem hiding (div)

import App.Component.Common.Carrousel.Component as Carrousel
import App.Component.Common.Carrousel.Type (Media(..))
import App.Component.Common.Modal.Component as Modal
import App.Component.Page.Home.HandleModalOutput (handleModalOutput)
import App.Component.Page.Home.Type (Action(..), Slots, State, modal)
import App.Component.Util.Type (noHtml, noSlotAddressIndex)
import App.Util.Capability.AppM (AppM)
import Halogen (ComponentHTML)
import Halogen.HTML (div, div_, slot, text)
import Halogen.HTML.Events (onClick)
import Util.File.Image.Common (ourImageRelativePath)

render :: State -> ComponentHTML Action Slots AppM
render s =
  div_
    [ div 
        [ onClick $ κ $ ShowModal ] 
        [ text $ "modal: " <> (s.showModal ? "visible" ↔ " hidden") ]
    , s.showModal
        ? (
          slot
            modal
            noSlotAddressIndex
            (Modal.component Carrousel.component)
            { closable: true 
            , innerInput: 
              { medias:
                  [ Image $ ourImageRelativePath "component/page" "kevin-francart"
                  , YoutubeVideo $ "https://www.youtube.com/watch?v=XEdMK67nD5E"
                  , Image $ ourImageRelativePath "component/page" "ellen-corin"
                  ]
              }
            }
            handleModalOutput
        )
        ↔ noHtml
    ]