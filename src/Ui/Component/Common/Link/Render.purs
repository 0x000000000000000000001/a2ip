module Ui.Component.Common.Link.Render
  ( render
  )
  where

import Proem hiding (div)

import Ui.Component.Common.Link.Style.Link (link)
import Ui.Component.Common.Link.Style.Sheet (sheet)
import Ui.Component.Common.Link.Type (Action(..), Slots, State)
import Ui.Util.Capability.AppM (AppM)
import Ui.Util.Capability.Navigate (routeCodec)
import Halogen (ComponentHTML)
import Halogen.HTML.Events (onClick)
import Halogen.HTML.Properties (href)
import Routing.Duplex (print)

render :: State -> ComponentHTML Action Slots AppM
render s@{ id, input: { route, classes: classes', children } } = 
  link id (classes' ??⇒ [])
    ( route 
        ?? (\r -> [ 
          href $ print routeCodec r 
        , onClick $ HandleClick r
        ]) 
        ⇔ []
    )
    ( [ sheet s ]
      <> children
    )