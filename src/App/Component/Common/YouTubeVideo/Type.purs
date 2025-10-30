module App.Component.Common.YoutubeVideo.Type
  ( Action(..)
  , YoutubeVideoM
  , Input
  , Output
  , Query
  , Slots
  , State
  )
  where

import App.Component.Util.Type (NoOutput, NoQuery, NoSlots)
import App.Util.Capability.AppM (AppM)
import Halogen (HalogenM)

type Input = 
  { url :: String 
  }

type Output = NoOutput

type Slots :: ∀ k. Row k
type Slots = NoSlots

type State = 
  { input :: Input
  }

data Action = Receive Input

type Query :: ∀ k. k -> Type
type Query = NoQuery

type YoutubeVideoM a = HalogenM State Action Slots Output AppM a
