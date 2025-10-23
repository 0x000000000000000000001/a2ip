module App.Component.Common.Modal.Type
  ( Action(..)
  , ModalM
  , Input
  , Output
  , Query
  , Slots
  , State
  )
  where

import App.Component.Util.Type (NoAction, NoInput, NoOutput, NoQuery, NoSlots, NoState)
import App.Util.Capability.AppM (AppM)
import Halogen (HalogenM)

type Input = NoInput

type Output = NoOutput

type Slots :: ∀ k. Row k
type Slots = NoSlots

type State = NoState

type Action = NoAction

type Query :: ∀ k. k -> Type
type Query = NoQuery

type ModalM a = HalogenM State Action Slots Output AppM a
