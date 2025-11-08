module App.Component.Common.PrettyErrorImage.Type
  ( Action(..)
  , Border
  , Input
  , Output
  , PrettyErrorImageM
  , Query
  , Slots
  , Sources
  , State
  , Style(..)
  , Try(..)
  , Url
  , defaultInput
  , defaultStyle
  )
  where

import Proem

import App.Component.Util.Type (MkState, NoOutput, NoQuery, NoSlots, Size)
import App.Util.Capability.AppM (AppM)
import Color (Color)
import Data.Maybe (Maybe(..))
import Halogen (HalogenM)
import Util.Style.Image (ObjectFit, fill)

type Url = String

type Sources = 
  { first :: Url
  , fallback :: Maybe Url
  }

type Border = 
  { radius :: Maybe Size
  , width :: Maybe Number
  , color :: Maybe Color
  }

type Style =
  { fit :: Maybe ObjectFit
  , width :: Maybe Size
  , height :: Maybe Size
  , border :: Maybe Border
  , questionMark :: 
      { when :: 
          { errored :: 
              { color :: Maybe Color
              }
          }
      }
  , when :: 
      { errored :: 
          { backgroundColor :: Maybe Color
          }
      }
  }

type Input =
  { loading :: Boolean
  , sources :: Sources
  , style :: Style
  } 

defaultStyle :: Style
defaultStyle = 
  { fit: Just fill
  , width: Nothing
  , height: Nothing
  , border: Nothing
  , questionMark: 
      { when: 
          { errored: 
              { color: Nothing
              }
          }
      }
  , when: 
      { errored: 
          { backgroundColor: Nothing
          }
      }
  }

defaultInput :: Input
defaultInput =
  { loading: false
  , sources: 
      { first: ""
      , fallback: Nothing
      }
  , style: defaultStyle
  }
 
type Output = NoOutput

type Slots :: ∀ k. Row k
type Slots = NoSlots

data Try = FirstTry Url | FallbackTry Url | StopTrying

derive instance eqTry :: Eq Try

type State = MkState
  ( input :: Input
  , try :: Try
  )

data Action
  = HandleError
  | Receive Input

type Query :: ∀ k. k -> Type
type Query = NoQuery

type PrettyErrorImageM a = HalogenM State Action Slots Output AppM a
