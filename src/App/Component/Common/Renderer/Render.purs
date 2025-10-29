module App.Component.Common.Renderer.Render
  ( render
  ) where

import Proem hiding (div)

import App.Component.Common.Renderer.Type (Action, Slots, State)
import App.Util.Capability.AppM (AppM)
import Halogen (ComponentHTML)
import Unsafe.Coerce (unsafeCoerce)

render :: ∀ w i. State w i -> ComponentHTML (Action w i) Slots AppM
render s = unsafeCoerce s
