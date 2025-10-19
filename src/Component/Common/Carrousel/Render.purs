module Component.Common.Carrousel.Render
  ( render
  ) where

import Proem hiding (div)

import Capability.AppM (AppM)
import Component.Common.Carrousel.Type (Action(..), Slots, State)
import Data.Array ((!!))
import Halogen (ComponentHTML)
import Halogen.HTML (div, text)
import Halogen.HTML.Events (onClick)
import Util.Style (class_)

render :: State -> ComponentHTML Action Slots AppM
render s = 
  div 
  [ class_ "carrousel"
  ]
  [ text $ show $ s.imageSources !! s.index
  , div
    [ class_ "prev" 
    , onClick $ κ GoToPrevious
    ]
    [ text "< Prev" ]
  , div
    [ class_ "next"
    , onClick $ κ GoToNext
    ]
    [ text "Next >" ]
  ]