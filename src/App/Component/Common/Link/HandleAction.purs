module App.Component.Common.Link.HandleAction
  ( handleAction
  )
  where

import Proem

import App.Util.Capability.Navigate (navigate)
import App.Component.Common.Link.Type (Action(..), LinkM, Output(..))
import Halogen (modify_, raise)
import Web.Event.Event (preventDefault)
import Web.UIEvent.MouseEvent (MouseEvent, altKey, button, ctrlKey, metaKey, shiftKey, toEvent)

handleAction :: Action -> LinkM Unit
handleAction = case _ of
  Receive input -> modify_ _ { input = input }
  
  Navigate route -> navigate route
  
  HandleClick route ev -> 
    when (isSimpleClick ev) do
      ʌ $ preventDefault $ toEvent ev
      handleAction $ Navigate route
      raise $ Clicked route ev

isSimpleClick :: MouseEvent -> Boolean
isSimpleClick ev =
  button ev == 0 && -- Left
  not (ctrlKey ev) &&
  not (metaKey ev) && -- Cmd on macos
  not (shiftKey ev) &&
  not (altKey ev)