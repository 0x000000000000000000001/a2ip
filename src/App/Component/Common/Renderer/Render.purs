module App.Component.Common.Renderer.Render
  ( render
  ) where

import Proem hiding (div)

import App.Component.Common.Modal.HandleInnerOutput (handleInnerOutput)
import App.Component.Common.Modal.Style.Close as Close
import App.Component.Common.Modal.Style.Core as Core
import App.Component.Common.Modal.Style.Modal (classId)
import App.Component.Common.Modal.Style.Sheet (sheet)
import App.Component.Common.Modal.Type (Action(..), Slots, State, inner)
import App.Component.Util.Type (noHtml, noSlotAddressIndex)
import App.Util.Capability.AppM (AppM)
import Halogen (Component, ComponentHTML)
import Halogen.HTML (div, slot)
import Halogen.HTML.Events (onClick)
import Html.Renderer.Halogen (render_)
import Util.Style (class_)

render :: State -> ComponentHTML Action Slots AppM
render s = s.innerHtml
