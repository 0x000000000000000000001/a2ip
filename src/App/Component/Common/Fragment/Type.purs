module App.Component.Common.Fragment.Type
  ( Action(..)
  , Input
  , Output(..)
  , Query
  , FragmentM
  , Slots
  , State
  )
  where

import App.Component.Util.Type (NoOutput, NoSlots, NoQuery)
import App.Util.Capability.AppM (AppM)
import Halogen (HalogenM)
import Halogen.HTML (HTML)

type Input w i = HTML w i

type Output = NoOutput

type Slots :: ∀ k. Row k
type Slots = NoSlots

type State w i = Input w i

data Action w i = Receive (Input w i)

type Query :: ∀ k. k -> Type
type Query = NoQuery

type FragmentM w i a = HalogenM (State w i) (Action w i) Slots Output AppM a
