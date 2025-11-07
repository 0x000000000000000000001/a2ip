module App.Component.Common.YoutubeVideo.Type
  ( Action(..)
  , Input
  , Output
  , Query
  , Slots
  , State
  , Style
  , YoutubeVideoM
  , defaultStyle
  )
  where

import App.Component.Util.Type (NoOutput, NoQuery, NoSlots, MkState)
import App.Util.Capability.AppM (AppM)
import CSS (Size)
import Data.Maybe (Maybe(..))
import Halogen (HalogenM)

type Style u = 
  { width :: Maybe (Size u)
  , height :: Maybe (Size u)
  }

defaultStyle :: ∀ u. Style u
defaultStyle =
  { width: Nothing
  , height: Nothing
  }

type Input u = 
  { url :: String 
  , style :: Style u
  }

type Output = NoOutput

type Slots :: ∀ k. Row k
type Slots = NoSlots

type State u = MkState
  ( input :: Input u
  )

data Action u = Initialize | Receive (Input u)

type Query :: ∀ k. k -> Type
type Query = NoQuery

type YoutubeVideoM u a = HalogenM (State u) (Action u) Slots Output AppM a
