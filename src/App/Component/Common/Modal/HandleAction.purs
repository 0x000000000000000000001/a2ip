module App.Component.Common.Modal.HandleAction
  ( handleAction
  ) where

import Proem

import App.Component.Common.Modal.Style.Modal as Modal
import App.Component.Common.Modal.Style.Close as Close
import App.Component.Common.Modal.Type (Action(..), ModalM, Output(..))
import Data.String (Pattern(..), contains)
import Halogen.Query.HalogenM (raise)
import Web.DOM.Element (className)
import Web.Event.Event (target)
import Web.HTML.HTMLElement (fromEventTarget, toElement)
import Web.UIEvent.MouseEvent (toEvent)

handleAction :: Action -> ModalM Unit
handleAction = case _ of
  HandleClick mouseEvent -> do
    let event = toEvent mouseEvent
        eventTarget = target event
        htmlElement = eventTarget >>= fromEventTarget
        element = htmlElement >>= (η ◁ toElement)
        
    classNameStr <- element ?? (ʌ ◁ className) ⇔ η ""
    
    let shouldClose = (
      contains (Pattern Modal.classId) classNameStr
      || contains (Pattern Close.classId) classNameStr
    )

    when shouldClose do
      raise Closed