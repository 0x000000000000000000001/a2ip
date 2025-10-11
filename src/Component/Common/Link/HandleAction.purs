module Component.Common.Link.HandleAction
  ( handleAction
  )
  where

import Proem

import Capability.AppM (AppM)
import Capability.Navigate (navigate)
import Component.Common.Link.Type (Action(..), Output, Slots, State)
import Halogen (HalogenM, modify_)

handleAction :: Action -> HalogenM State Action Slots Output AppM Unit
handleAction = case _ of
  Receive input -> modify_ _ { route = input.route, class_ = input.class_, display = input.display, children = input.children }
  Navigate route -> navigate route