module App.Component.Common.Modal.Component
  ( component
  , modal
  )
  where

import Proem

import App.Component.Common.Modal.HandleAction (handleAction)
import App.Component.Common.Modal.Render (render)
import App.Component.Common.Modal.Type (Action(..), Input, Output)
import App.Util.Capability.AppM (AppM)
import Data.Array (replicate)
import Data.Int (hexadecimal, toStringAs, floor)
import Data.Maybe (Maybe(..))
import Data.String (joinWith)
import Data.Symbol (class IsSymbol)
import Data.Traversable (traverse)
import Effect (Effect)
import Effect.Random (random)
import Effect.Unsafe (unsafePerformEffect)
import Halogen (Component, Slot, ComponentHTML, defaultEval, mkComponent, mkEval)
import Halogen.HTML (slot)
import Prim.Row (class Cons)
import Type.Prelude (Proxy)

generateId :: Effect String
generateId = do
  parts <- traverse randomHex (replicate 4 unit)
  pure $ joinWith "-" parts
  where
    randomHex :: Unit -> Effect String
    randomHex _ = do
      n <- random
      pure $ toStringAs hexadecimal (floor (n * 65536.0))

component
  :: ∀ q i o
   . Component q i o AppM
  -> Component q (Input i) (Output o) AppM
component innerComponent = mkComponent
  { initialState: \input -> 
      { input
      , id: unsafePerformEffect generateId
      }
  , render: render innerComponent
  , eval: 
      mkEval 
      defaultEval 
        { handleAction = handleAction
        , receive = Just ◁ Receive
        , initialize = Just Initialize
        }
  }

modal 
  :: ∀ action slots label slotAddressIndex slots' query input output
   . Cons label (Slot query (Output output) slotAddressIndex) slots' slots
  => IsSymbol label
  => Ord slotAddressIndex
  => Component query input output AppM
  -> Proxy label
  -> slotAddressIndex
  -> Input input
  -> (Output output -> action)
  -> ComponentHTML action slots AppM
modal innerComponent _slotLabel slotAddressIndex input outputAction = 
  slot
    _slotLabel
    slotAddressIndex
    (component innerComponent)
    input
    outputAction