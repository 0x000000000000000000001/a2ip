module Component.Util.Type where

import Prelude

import Data.Const (Const)

type GenericSlots :: forall k. Row k
type GenericSlots = ()

type GenericInput = Unit

type GenericOutput = Void

type GenericState = {}

data GenericAction

type GenericQuery :: forall k. k -> Type
type GenericQuery = Const Void
