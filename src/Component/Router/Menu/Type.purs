module Component.Router.Menu.Type
  ( Action(..)
  , MenuM
  , Input
  , Output
  , Query
  , Slots
  , State
  , items
  )
  where

import Component.Util.Capability.AppM (AppM)
import Component.Common.Link.Type as Link
import Component.Router.Route (Route)
import Component.Util.Type (NoInput, NoOutput, NoQuery)
import Data.Maybe (Maybe)
import Data.Tuple (Tuple)
import Halogen (HalogenM, Slot)
import Type.Prelude (Proxy(..))
import Web.UIEvent.MouseEvent (MouseEvent)

type Slots = 
  ( items :: Slot Link.Query Link.Output (Tuple String (Maybe Route))
  )

items = Proxy :: Proxy "items"

type State = 
  { isUnfold :: Boolean 
  , isAnimating :: Boolean
  }

data Action 
  = ToggleFolding Boolean 
  | HandleItemClick MouseEvent
  | FinishAnimation

type Input = NoInput

type Output = NoOutput

type Query :: ∀ k. k -> Type
type Query = NoQuery

type MenuM a = HalogenM State Action Slots Output AppM a

