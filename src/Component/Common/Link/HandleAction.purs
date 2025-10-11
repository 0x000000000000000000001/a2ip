module Component.Common.Link.HandleAction
  ( handleAction
  )
  where

import Proem

import Capability.AppM (AppM)
import Capability.Navigate (navigate)
import Component.Common.Link.Type (Action(..), Output, Slots, State)
import Halogen (HalogenM, liftEffect, modify_)
import Web.Event.Event (preventDefault)
import Web.UIEvent.MouseEvent (toEvent)

handleAction :: Action -> HalogenM State Action Slots Output AppM Unit
handleAction = case _ of
  Receive input -> modify_ _ { route = input.route, class_ = input.class_, display = input.display, children = input.children }
  Navigate route -> navigate route
  HandleClick route ev -> do 
    liftEffect $ preventDefault $ toEvent ev
    route ?? (\r -> handleAction $ Navigate r) ⇔ pure unit