module App.Component.Common.PrettyErrorImage.Type
  ( Action(..)
  , Input
  , Output
  , PrettyErrorImageM
  , Query
  , Slots
  , Sources
  , State
  , Style
  , Try(..)
  , Url
  , defaultInput
  , defaultStyle
  )
  where

import Proem

import App.Component.Util.Type (NoOutput, NoQuery, NoSlots, MkState)
import App.Util.Capability.AppM (AppM)
import CSS (Size)
import Color (Color)
import Data.Maybe (Maybe(..))
import Halogen (HalogenM)
import Util.Style.Image (ObjectFit, fill)

type Url = String

type Sources = 
  { first :: Url
  , fallback :: Maybe Url
  }

type Style u = 
  { fit :: Maybe ObjectFit
  , width :: Maybe (Size u)
  , height :: Maybe (Size u)
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

type Input u =
  { loading :: Boolean
  , sources :: Sources
  , style :: Style u
  } 

defaultStyle :: ∀ u. Style u
defaultStyle =
  { fit: Just fill
  , width: Nothing
  , height: Nothing
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

defaultInput :: ∀ u. Input u
defaultInput =
  { class_: Nothing
  , loading: false
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

type State u = MkState
  ( input :: Input u
  , try :: Try
  )

data Action u
  = HandleError
  | Receive (Input u)

type Query :: ∀ k. k -> Type
type Query = NoQuery

type PrettyErrorImageM u a = HalogenM (State u) (Action u) Slots Output AppM a
