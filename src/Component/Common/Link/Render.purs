module Component.Common.Link.Render
  ( render
  )
  where

import Proem hiding (div)

import Capability.AppM (AppM)
import Component.Common.Link.Type (Action, Slots, State)
import Halogen (ComponentHTML)
import Halogen.HTML (a)
import Halogen.HTML.Properties (href)

render :: State -> ComponentHTML Action Slots AppM
render s = a [ href s.href ] s.children