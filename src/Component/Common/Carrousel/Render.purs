module Component.Common.Carrousel.Render
  ( render
  ) where

import Proem hiding (div)

import Component.Util.Capability.AppM (AppM)
import Component.Common.Carrousel.Style.Carrousel (classId)
import Component.Common.Carrousel.Style.Control.Control as Control
import Component.Common.Carrousel.Style.Control.Icon as Icon
import Component.Common.Carrousel.Style.Sheet (sheet)
import Component.Common.Carrousel.Type (Action(..), Slots, State, indexImage)
import Component.Common.PrettyErrorImage.Component as PrettyErrorImage
import Component.Util.Type (noOutputAction, noSlotAddressIndex)
import Data.Array ((!!))
import Data.Maybe (Maybe(..))
import Halogen (ComponentHTML)
import Halogen.HTML (div, slot, text)
import Halogen.HTML.Events (onClick)
import Util.Style (class_, classes)

render :: State -> ComponentHTML Action Slots AppM
render s = 
  div 
  [ class_ classId ]
  [ sheet
  , slot 
      indexImage 
      noSlotAddressIndex 
      PrettyErrorImage.component
      { src: s.imageSources !! s.index
      , fallbackSrc: Nothing
      , class_: Nothing
      }
      noOutputAction
  , div
    [ classes [ Control.classId, Control.classIdWhenPrev ]
    , onClick $ κ GoToPrevious
    ]
    [ div [ class_ Icon.classId ] [ text "◀︎" ] ]
  , div
    [ classes [ Control.classId, Control.classIdWhenNext ]
    , onClick $ κ GoToNext
    ]
    [ div [ class_ Icon.classId ] [ text "▶︎" ] ]
  ]