module Component.Util.Type where

import Prelude

import Data.Const (Const)

type NoSlots :: forall k. Row k
type NoSlots = ()

type NoInput = Unit

type NoOutput = Void

type NoState = {}

data NoAction

type NoQuery :: forall k. k -> Type
type NoQuery = Const Void
