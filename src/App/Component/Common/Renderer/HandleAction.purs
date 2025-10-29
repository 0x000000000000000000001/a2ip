module App.Component.Common.Renderer.HandleAction
  ( handleAction
  ) where

import Proem

import App.Component.Common.Renderer.Type (Action(..), RendererM)
import Halogen (modify_)

handleAction :: Action -> RendererM Unit
handleAction = case _ of
  Receive i -> modify_ _ { innerHtml = i.innerHtml }