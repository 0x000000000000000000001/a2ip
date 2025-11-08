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

type Style = 
  { width :: ∀ u. Maybe (Size u)
  , height :: ∀ u. Maybe (Size u)
  }

defaultStyle :: Style
defaultStyle =
  { width: Nothing
  , height: Nothing
  }

type Input = 
  { url :: String 
  , style :: Style
  }

type Output = NoOutput

type Slots :: ∀ k. Row k
type Slots = NoSlots

type State = MkState
  ( input :: Input
  )

data Action = Initialize | Receive Input

type Query :: ∀ k. k -> Type
type Query = NoQuery

type YoutubeVideoM a = HalogenM State Action Slots Output AppM a
