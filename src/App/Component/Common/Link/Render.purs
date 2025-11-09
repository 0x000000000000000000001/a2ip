module App.Component.Common.Link.Render
  ( render
  )
  where

import Proem hiding (div)

import App.Component.Common.Link.Style.Link (class', staticClass)
import App.Component.Common.Link.Style.Sheet (sheet)
import App.Component.Common.Link.Type (Action(..), Slots, State)
import App.Util.Capability.AppM (AppM)
import App.Util.Capability.Navigate (routeCodec)
import Halogen (ComponentHTML)
import Halogen.HTML (a)
import Halogen.HTML.Events (onClick)
import Halogen.HTML.Properties (href)
import Routing.Duplex (print)
import Util.Style.Style (classes)

render :: State -> ComponentHTML Action Slots AppM
render s@{ id, input: { route, classes: classes', children } } = 
  a
    ( [ classes 
          ( [ staticClass
            , class' id
            ] <> (classes' ??⇒ [])
          )
      ] <> (
        route 
          ?? (\r -> [ 
            href $ print routeCodec r 
          , onClick $ HandleClick r
          ]) 
          ⇔ []
      )
    )
    ( [ sheet s ]
      <> children
    )