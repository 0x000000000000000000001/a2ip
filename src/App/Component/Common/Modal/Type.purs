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

import App.Component.Util.Type (NoQuery, NoSlots)
import App.Util.Capability.AppM (AppM)
import Halogen (HalogenM)
import Web.UIEvent.MouseEvent (MouseEvent)

type Input = 
  { closable :: Boolean
  }

data Output = Closed

type Slots :: ∀ k. Row k
type Slots = NoSlots

type State = 
  { closable :: Boolean
  }

data Action = Receive Input | HandleClick MouseEvent | HandleCloseClick

type Query :: ∀ k. k -> Type
type Query = NoQuery

type ModalM a = HalogenM State Action Slots Output AppM a
