module Component.Util.Type where

import Proem

import Capability.AppM (AppM)
import Data.Const (Const)
import Halogen (ComponentHTML)

type Children action slots = Array (ComponentHTML action slots AppM)

type NoSlots :: ∀ k. Row k
type NoSlots = ()

type NoInput = Unit

type NoOutput = Void

type NoState = {}

data NoAction

type NoQuery :: ∀ k. k -> Type
type NoQuery = Const Void

type NoSlotAddressIndex = Unit

noOutputAction :: ∀ a. NoOutput -> a 
noOutputAction = absurd

noSlotAddressIndex :: NoSlotAddressIndex
noSlotAddressIndex = unit

noInput :: NoInput
noInput = unit

noState :: NoState 
noState = {}
