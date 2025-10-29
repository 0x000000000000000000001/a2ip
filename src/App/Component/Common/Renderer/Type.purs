module App.Component.Common.Renderer.Type
  ( Action(..)
  , Input
  , Output(..)
  , Query
  , RendererM
  , Slots
  , State
  )
  where

import App.Util.Capability.AppM (AppM)
import Component.Util.Type (NoOutput, NoQuery, NoSlots)
import Halogen (ComponentHTML, HalogenM)

type Input = 
  { innerHtml :: ComponentHTML Action Slots AppM
  }

type Output = NoOutput

type Slots :: forall k. Row k
type Slots = NoSlots

type State = 
  { innerHtml :: ComponentHTML Action Slots AppM
  }

data Action = Receive Input

type Query :: ∀ k. k -> Type
type Query = NoQuery

type RendererM a = HalogenM State Action Slots Output AppM a
