module App.Component.Util.Type where

import Proem

import App.Util.Capability.AppM (AppM)
import Data.Const (Const)
import Halogen (ComponentHTML)
import Halogen.HTML (HTML, text)
import Network.RemoteData (RemoteData)

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

type Remote a = RemoteData String a

noOutputAction :: ∀ a. NoOutput -> a 
noOutputAction = absurd

noSlotAddressIndex :: NoSlotAddressIndex
noSlotAddressIndex = ι

noInput :: NoInput
noInput = ι

noState :: NoState 
noState = {}

noState' :: ∀ a. a -> NoState
noState' = κ noState

noHtml :: ∀ w i. HTML w i
noHtml = text ""