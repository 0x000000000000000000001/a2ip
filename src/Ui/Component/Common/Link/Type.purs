module Ui.Component.Common.Link.Type
  ( Action(..)
  , LinkM
  , Input
  , Output(..)
  , Query
  , Slots
  , State
  , defaultInput
  )
  where

import Ui.Component.Util.Type (Children, NoQuery, NoSlots, WithId)
import Ui.Util.Capability.AppM (AppM)
import Ui.Util.Capability.Navigate (Route(..))
import CSS (Display, inlineBlock)
import Data.Maybe (Maybe(..))
import Halogen (HalogenM)
import Web.UIEvent.MouseEvent (MouseEvent)

type Input =
  { route :: Maybe Route
  , classes :: Maybe (Array String)
  , display :: Display
  , children :: Children Action Slots
  } 

defaultInput :: Input
defaultInput = 
  { route: Just Home 
  , classes: Nothing
  , display: inlineBlock
  , children: []
  }
 
data Output = Clicked Route MouseEvent

type Slots :: ∀ k. Row k
type Slots = NoSlots

type State = WithId
  ( input :: Input
  )

data Action 
  = Navigate Route 
  | Receive Input
  | HandleClick Route MouseEvent

type Query :: ∀ k. k -> Type
type Query = NoQuery

type LinkM a = HalogenM State Action Slots Output AppM a
