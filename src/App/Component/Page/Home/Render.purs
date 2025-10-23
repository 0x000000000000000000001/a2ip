module App.Component.Page.Home.Render
  ( render
  ) where

import Proem hiding (div)

import App.Component.Common.Carrousel.Component as Carrousel
import App.Component.Page.Home.Type (Action, Slots, State, carrousel)
import App.Component.Util.Type (noOutputAction, noSlotAddressIndex)
import App.Util.Capability.AppM (AppM)
import Halogen (ComponentHTML)
import Halogen.HTML (div, slot)
import Util.File.Image.Common (ourImageRelativePath)

render :: State -> ComponentHTML Action Slots AppM
render _ =
  div
    []
    [ slot 
        carrousel 
        noSlotAddressIndex 
        Carrousel.component
        { imageSources:
            [ ourImageRelativePath "component/page" "kevin-francart"
            , ourImageRelativePath "component/page" "ellen-corin"
            ]
        }
        noOutputAction
    ]