module Component.Page.Seminars.Type   where

import Component.Util.Type (NoAction, NoInput, NoOutput, NoQuery, NoSlots, NoState)

type Input = NoInput

type Output = NoOutput

type Slots :: forall k. Row k
type Slots = NoSlots

type State = NoState

type Action = NoAction

type Query :: ∀ k. k -> Type
type Query = NoQuery
