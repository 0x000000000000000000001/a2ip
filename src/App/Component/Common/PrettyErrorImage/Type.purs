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
  , defaultInputStyle
  )
  where

import App.Component.Util.Type (NoOutput, NoQuery, NoSlots, MkState)
import App.Util.Capability.AppM (AppM)
import CSS (darken)
import Color (Color)
import Data.Eq (class Eq)
import Data.Maybe (Maybe(..))
import Halogen (HalogenM)
import Util.Style.Style (loadingGrey)
import Util.Style.Image (ObjectFit, fill)

type Url = String

type Sources = 
  { first :: Url
  , fallback :: Maybe Url
  }

type Style = 
  { when :: 
      { errored :: 
          { backgroundColor :: Color
          }
      }
  , fit :: ObjectFit
  , questionMark :: 
      { when :: 
          { errored :: 
              { color :: Color
              }
          }
      }
  }

type Input =
  { class_ :: Maybe String
  , loading :: Boolean
  , sources :: Sources
  , style :: Style
  } 

defaultInputStyle :: Style
defaultInputStyle =
  { when: 
      { errored: 
          { backgroundColor: loadingGrey
          }
      }
  , fit: fill
  , questionMark: 
      { when: 
          { errored: 
              { color: darken 0.4 loadingGrey
              }
          }
      }
  }

defaultInput :: Input
defaultInput =
  { class_: Nothing
  , loading: false
  , sources: 
      { first: ""
      , fallback: Nothing
      }
  , style: defaultInputStyle
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
