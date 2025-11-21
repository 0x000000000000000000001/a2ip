module Ui.Component.Common.Input.Type
  ( Action(..)
  , Input
  , InputM
  , Output(..)
  , Query
  , Slots
  , State
  , Style
  , defaultInput
  , defaultStyle
  )
  where

import Ui.Component.Util.Type (NoQuery, NoSlots, WithId)
import Ui.Util.Capability.AppM (AppM)
import Color (Color)
import Data.Maybe (Maybe(..))
import Effect.Ref (Ref)
import Halogen (HalogenM)
import Web.UIEvent.MouseEvent (MouseEvent)

type Style = 
  { backgroundColor :: Maybe Color
  , placeholderColor :: Maybe Color
  , textColor :: Maybe Color
  , border :: 
      { color :: Maybe Color
      , width :: 
          { top :: Maybe Number
          , right :: Maybe Number
          , bottom :: Maybe Number
          , left :: Maybe Number
          }
      }
  }

defaultStyle :: Style
defaultStyle =
  { backgroundColor: Nothing
  , placeholderColor: Nothing
  , textColor: Nothing
  , border: 
      { color: Nothing
      , width: 
          { top: Nothing
          , right: Nothing
          , bottom: Nothing
          , left: Nothing
          } 
      }
  }

type Input =
  { placeholder :: Maybe String
  , label :: Maybe String
  , initialValue :: String
  , style :: Style
  } 

defaultInput :: Input
defaultInput = 
  { placeholder: Nothing
  , label: Nothing
  , initialValue: ""
  , style: defaultStyle
  }
 
data Output = ChangedValue String

type Slots :: ∀ k. Row k
type Slots = NoSlots

type State = WithId
  ( input :: Input
  , value :: Maybe (Ref String)
  , open :: Boolean
  )

data Action 
  = Initialize
  | Receive Input
  | HandleNewValue String
  | HandleFocus
  | HandleBlur
  | HandleClick
  | HandleLabelClick MouseEvent
  | HandleLabelMouseDown MouseEvent

type Query :: ∀ k. k -> Type
type Query = NoQuery

type InputM = HalogenM State Action Slots Output AppM
