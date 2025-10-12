module Component.Common.Link.HandleAction
  ( handleAction
  )
  where

import Proem

import Capability.AppM (AppM)
import Capability.Navigate (navigate)
import Component.Common.Link.Type (Action(..), Output(..), Slots, State)
import Halogen (HalogenM, liftEffect, modify_, raise)
import Web.Event.Event (preventDefault)
import Web.UIEvent.MouseEvent (MouseEvent, altKey, button, ctrlKey, metaKey, shiftKey, toEvent)

handleAction :: Action -> HalogenM State Action Slots Output AppM Unit
handleAction = case _ of
  Receive input -> modify_ _ { route = input.route, class_ = input.class_, display = input.display, children = input.children }
  Navigate route -> navigate route
  HandleClick route ev -> 
    when (isSimpleClick ev) do
      liftEffect $ preventDefault $ toEvent ev
      handleAction $ Navigate route
      raise $ Clicked route

isSimpleClick :: MouseEvent -> Boolean
isSimpleClick ev =
  button ev == 0 && -- Left
  not (ctrlKey ev) &&
  not (metaKey ev) && -- Cmd on macos
  not (shiftKey ev) &&
  not (altKey ev)