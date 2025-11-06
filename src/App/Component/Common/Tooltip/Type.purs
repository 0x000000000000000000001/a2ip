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
import Halogen (HalogenM, ComponentHTML)
import Util.Style (Position)

type PositionDelta = { x :: Number, y :: Number } -- in rem

type OuterPosition = { pos :: Position, delta :: PositionDelta }

type Input action slots w i = 
  { inner :: ComponentHTML (action w i) slots AppM
  , outer :: ComponentHTML (action w i) slots AppM
  , outerPosition :: OuterPosition
  }

type Output = NoOutput

type Slots :: ∀ k. Row k
type Slots = NoSlots

type State action slots w i = 
  { input :: Input action slots w i
  , open :: Boolean
  }

data Action action slots w i = Initialize | Receive (Input action slots w i)

type Query :: ∀ k. k -> Type
type Query = NoQuery

type TooltipM action slots w i a = HalogenM (State action slots w i) (Action action slots w i) Slots Output AppM a
