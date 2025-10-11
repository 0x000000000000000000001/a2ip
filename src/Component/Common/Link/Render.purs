module Component.Common.Link.Render
  ( render
  )
  where

import Proem hiding (div)

import Capability.AppM (AppM)
import Component.Common.Link.Type (Action(..), Slots, State)
import Halogen (ComponentHTML)
import Halogen.HTML (a)
import Halogen.HTML.Events (onClick)
import Halogen.HTML.Properties (href)
import Util.Style (class_)

render :: State -> ComponentHTML Action Slots AppM
render s = a 
  ( [ href "https://google.com", class_ s.class_ ] 
    <> (s.route ?? (\r -> [ onClick $ const $ Navigate r ]) ⇔ [])
  )
  s.children