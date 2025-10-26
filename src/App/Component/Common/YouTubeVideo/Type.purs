module App.Component.Common.YouTubeVideo.Type
  ( Action(..)
  , YouTubeVideoM
  , Input
  , Output
  , Query
  , Slots
  , State
  )
  where

import App.Component.Util.Type (NoAction, NoInput, NoOutput, NoQuery, NoSlots, NoState)
import App.Util.Capability.AppM (AppM)
import Halogen (HalogenM)

type Input = 
  { url :: String 
  }

type Output = NoOutput

type Slots :: ∀ k. Row k
type Slots = NoSlots

type State = 
  { url :: String 
  }

data Action = Receive Input

type Query :: ∀ k. k -> Type
type Query = NoQuery

type YouTubeVideoM a = HalogenM State Action Slots Output AppM a
