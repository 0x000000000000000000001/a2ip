module App.Component.Common.Modal.HandleAction
  ( handleAction
  ) where

import Proem

import App.Component.Common.Modal.Style.Modal as Modal
import App.Component.Common.Modal.Type (Action(..), ModalM, Output(..))
import Data.String (Pattern(..), contains)
import Halogen (get, modify_)
import Halogen.Query.HalogenM (raise)
import Web.DOM.Element (className)
import Web.Event.Event (target)
import Web.HTML.HTMLElement (fromEventTarget, toElement)
import Web.UIEvent.MouseEvent (toEvent)

handleAction :: ∀ q i o. Action i o -> (ModalM q i o) Unit
handleAction = case _ of
  Initialize -> ηι

  Receive input -> modify_ _ { input = input }
  
  HandleCloseClick -> raise Closed

  HandleClick mouseEvent -> do
    state <- get

    when state.input.closable do
      let event = toEvent mouseEvent
          eventTarget = target event
          htmlElement = eventTarget >>= fromEventTarget
          element = htmlElement >>= (η ◁ toElement)
          
      classNameStr <- element ?? (ʌ ◁ className) ⇔ η ""
      
      let shouldClose = contains (Pattern $ Modal.class' state.id) classNameStr

      when shouldClose (raise Closed)

  RaiseInnerOutput output -> raise (InnerOutputRaised output)
