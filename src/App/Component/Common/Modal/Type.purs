module App.Component.Common.Modal.Type
  ( Action(..)
  , ModalM
  , Input
  , Output(..)
  , Query
  , Slots
  , State
  )
  where

import App.Component.Util.Type (NoInput, NoQuery, NoSlots, NoState)
import App.Util.Capability.AppM (AppM)
import Halogen (HalogenM)
import Web.UIEvent.MouseEvent (MouseEvent)

type Input = NoInput

data Output = Closed

type Slots :: ∀ k. Row k
type Slots = NoSlots

type State = NoState

data Action = HandleClick MouseEvent

type Query :: ∀ k. k -> Type
type Query = NoQuery

type ModalM a = HalogenM State Action Slots Output AppM a
