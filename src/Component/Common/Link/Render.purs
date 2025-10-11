module Component.Common.Link.Render
  ( render
  )
  where

import Proem hiding (div)

import Capability.AppM (AppM)
import Component.Common.Link.Style.Link (classId)
import Component.Common.Link.Style.Sheet (sheet)
import Component.Common.Link.Type (Action(..), Slots, State)
import Component.Router.Route (Route(..), routeCodec)
import Data.Array ((:))
import Halogen (ComponentHTML)
import Halogen.HTML (a)
import Halogen.HTML.Events (onClick)
import Halogen.HTML.Properties (href)
import Routing.Duplex (print)
import Util.Style (classes)

render :: State -> ComponentHTML Action Slots AppM
render s = a 
  ( [ 
      href $ print routeCodec $ s.route ??⇒ Home, 
      classes $ [ classId ] <> (s.class_ ?? (_ : []) ⇔ []) 
    ]
    <> (s.route ?? (\r -> [ onClick $ HandleClick s.route ]) ⇔ [])
  )
  ( [ sheet s ]
    <> s.children
  )