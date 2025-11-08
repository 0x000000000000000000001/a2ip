module App.Component.Util.Type
  ( BaseState
  , Children
  , MkState
  , NoAction(..)
  , NoInput
  , NoOutput
  , NoQuery
  , NoSlotAddressIndex
  , NoSlots
  , NoState
  , Remote
  , Size(..)
  , State
  , applyToSize
  , baseState
  , mkInput
  , noHtml
  , noInput
  , noOutputAction
  , noSlotAddressIndex
  , noState
  , noState'
  )
  where

import Proem

import App.Util.Capability.AppM (AppM)
import CSS (pct, rem)
import CSS as CSS
import CSS.Common (auto)
import Data.Const (Const)
import Data.Int (floor, hexadecimal, toStringAs)
import Effect (Effect)
import Effect.Now (nowTime)
import Effect.Random (random)
import Effect.Unsafe (unsafePerformEffect)
import Halogen (ComponentHTML)
import Halogen.HTML (HTML, text)
import Network.RemoteData (RemoteData)
import Prim.Row (class Lacks)
import Record (insert)
import Util.Proxy.Dictionary.Id (id')

type Children action slots = Array (ComponentHTML action slots AppM)

type NoSlots :: ∀ k. Row k
type NoSlots = ()

type NoInput = Unit

type NoOutput = Void

data Size 
  = Pct Number
  | Rem Number
  | Auto

type State r = { id :: String | r }
type MkState r = State r
type BaseState = MkState ()
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

baseState :: BaseState 
baseState = { id: unsafePerformEffect generateInstanceId }

noState :: NoState
noState = {}

noState' :: ∀ a. a -> NoState
noState' = κ noState

noInput :: NoInput
noInput = ι

mkInput :: ∀ i r. Lacks "id" r => (i -> { | r }) -> (i -> State r )
mkInput f i = insert id' (unsafePerformEffect generateInstanceId) (f i)

generateInstanceId :: Effect String
generateInstanceId = do
  n <- random
  let timestamp = unsafePerformEffect nowTime
  pure $ toStringAs hexadecimal (floor (n * 4294967296.0)) <> "-" <> show timestamp

noHtml :: ∀ w i. HTML w i
noHtml = text ""

applyToSize :: ∀ a. (∀ u. CSS.Size u -> a) -> Size -> a
applyToSize f = case _ of
  Pct p -> f (pct p)
  Rem r -> f (rem r)
  _ -> f auto
