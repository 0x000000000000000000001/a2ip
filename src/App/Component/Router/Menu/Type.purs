module App.Component.Router.Menu.Type
  ( Action(..)
  , Input
  , MenuM
  , Output
  , Query
  , Slots
  , State
  )
  where

import App.Component.Common.Link.Type as Link
import App.Component.Util.Type (NoInput, NoOutput, NoQuery, WithId)
import App.Util.Capability.AppM (AppM)
import App.Util.Capability.Navigate (Route)
import Data.Maybe (Maybe)
import Data.Tuple (Tuple)
import Halogen (HalogenM, Slot)
import Web.UIEvent.MouseEvent (MouseEvent)

type Slots = 
  ( items :: Slot Link.Query Link.Output (Tuple String (Maybe Route))
  )

type State = WithId
  ( unfold :: Boolean 
  , animating :: Boolean
  )

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

