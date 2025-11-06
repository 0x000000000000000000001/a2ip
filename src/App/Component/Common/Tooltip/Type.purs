module App.Component.Common.Tooltip.Type
  ( Action(..)
  , Input
  , OuterPosition
  , Output(..)
  , PositionDelta
  , Query
  , Slots
  , State
  , TooltipM
  )
  where

import App.Component.Util.Type (NoOutput, NoQuery, NoSlots)
import App.Util.Capability.AppM (AppM)
import Halogen (HalogenM)
import Halogen.HTML (HTML)
import Util.Style (Position)

type PositionDelta = { x :: Number, y :: Number } -- in rem

type OuterPosition = { pos :: Position, delta :: PositionDelta }

type Input w i = 
  { inner :: HTML w i
  , outer :: HTML w i
  , outerPosition :: OuterPosition
  }

type Output = NoOutput

type Slots :: ∀ k. Row k
type Slots = NoSlots

type State w i = 
  { input :: Input w i
  , open :: Boolean
  }

data Action w i = Initialize | Receive (Input w i)

type Query :: ∀ k. k -> Type
type Query = NoQuery

type TooltipM w i a = HalogenM (State w i) (Action w i) Slots Output AppM a
