module App.Component.Common.Renderer.HandleAction
  ( handleAction
  ) where

import Proem

import App.Component.Common.Renderer.Type (Action(..), RendererM)
import Halogen (put)
import Unsafe.Coerce (unsafeCoerce)

handleAction :: ∀ w i. Action w i -> RendererM w i Unit
handleAction = case _ of
  Receive i -> put $ unsafeCoerce i