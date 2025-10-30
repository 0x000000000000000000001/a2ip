module App.Component.Router.Menu.Type
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

import App.Component.Common.Link.Type as Link
import App.Component.Util.Type (NoInput, NoOutput, NoQuery)
import App.Util.Capability.AppM (AppM)
import App.Util.Capability.Navigate (Route)
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
  = Initialize
  | ToggleFolding Boolean 
  | HandleDocClick MouseEvent
  | FinishAnimation
  | DoNothing

type Input = NoInput

type Output = NoOutput

type Query :: ∀ k. k -> Type
type Query = NoQuery

type MenuM a = HalogenM State Action Slots Output AppM a

