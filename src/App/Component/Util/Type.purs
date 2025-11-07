module App.Component.Util.Type where

import Proem

import App.Util.Capability.AppM (AppM)
import Data.Array (replicate)
import Data.Const (Const)
import Data.Int (floor, hexadecimal, toStringAs)
import Data.String (joinWith)
import Data.Traversable (traverse)
import Effect (Effect)
import Effect.Now (nowTime)
import Effect.Random (random)
import Effect.Unsafe (unsafePerformEffect)
import Halogen (ComponentHTML)
import Halogen.HTML (HTML, text)
import Network.RemoteData (RemoteData)
import Prim.Row (class Lacks)
import Record (insert)
import Type.Proxy (Proxy(..))
import Type.Row (type (+))
import Util.Proxy.Dictionary.Id (id')

type Children action slots = Array (ComponentHTML action slots AppM)

type NoSlots :: ∀ k. Row k
type NoSlots = ()

type NoInput = Unit

type NoOutput = Void

type StateIdRow = ( id :: String )

type State r = { | StateIdRow + r }

type NoState = State ()

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

mkInput :: ∀ i r. Lacks "id" r => (i -> { | r }) -> (i -> { id :: String | r })
mkInput f i = insert id' (unsafePerformEffect generateInstanceId) (f i)

generateInstanceId :: Effect String
generateInstanceId = do
  n <- random
  let timestamp = unsafePerformEffect nowTime
  pure $ toStringAs hexadecimal (floor (n * 4294967296.0)) <> "-" <> show timestamp