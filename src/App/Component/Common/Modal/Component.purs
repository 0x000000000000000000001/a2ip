module App.Component.Common.Modal.Component
  ( component
  ) where

import Proem

import App.Component.Common.Modal.Render (render)
import App.Component.Common.Modal.Style.Modal as Modal
import App.Component.Common.Modal.Type (Action(..), Input, ModalM, Output, Query)
import App.Component.Util.Type (noState')
import App.Util.Capability.AppM (AppM)
import App.Util.Capability.Log (debug)
import Data.String (Pattern(..), contains)
import Halogen (Component, defaultEval, mkComponent, mkEval)
import Web.DOM.Element (className)
import Web.Event.Event (target)
import Web.HTML.HTMLElement (fromEventTarget, toElement)
import Web.UIEvent.MouseEvent (toEvent)

component :: Component Query Input Output AppM
component = mkComponent
  { initialState: noState'
  , render
  , eval: mkEval defaultEval { handleAction = handleAction }
  }

handleAction :: Action -> ModalM Unit
handleAction = case _ of
  HandleClick mouseEvent -> do
    let event = toEvent mouseEvent
        eventTarget = target event
        htmlElement = eventTarget >>= fromEventTarget
        element = htmlElement >>= (η ◁ toElement)
        
    classNameStr <- element ?? (ʌ ◁ className) ⇔ η ""
    
    let shouldClose = contains (Pattern Modal.classId) classNameStr

    when shouldClose do
      debug "modal closed"