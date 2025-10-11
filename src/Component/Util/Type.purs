module Component.Util.Type where

import Proem

import Data.Const (Const)

type NoSlots :: forall k. Row k
type NoSlots = ()

type NoInput = Unit

type NoOutput = Void

type NoState = {}

data NoAction

type NoQuery :: forall k. k -> Type
type NoQuery = Const Void

type NoSlotAddressIndex = Unit

noOutputAction :: forall a. NoOutput -> a 
noOutputAction = absurd

noSlotAddressIndex :: NoSlotAddressIndex
noSlotAddressIndex = unit

noInput :: NoInput
noInput = unit
