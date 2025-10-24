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
import Data.Maybe (fromMaybe)
import Data.Traversable (for)
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
  BackgroundClicked mouseEvent -> do
    shouldClose <- ʌ do
      let event = toEvent mouseEvent
      for (target event) \eventTarget -> do
        for (fromEventTarget eventTarget) \htmlElement -> do
          let element = toElement htmlElement
          classNameStr <- className element
          η (classNameStr == Modal.classId)
    when (fromMaybe false (μ shouldClose)) do
      debug "modal closed"