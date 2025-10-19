module Component.Common.Carrousel.Type
  ( Action(..)
  , Input
  , Output
  , Query
  , Slots
  , State
  )
  where

import Component.Util.Type (NoOutput, NoQuery, NoSlots)

type Input = 
  { imageSources :: Array String
  }
 
type Output = NoOutput

type Slots :: ∀ k. Row k
type Slots = NoSlots

type State = 
  { index :: Int
  , imageSources :: Array String
  }

data Action = GoToPrevious | GoToNext | Receive Input

type Query :: ∀ k. k -> Type
type Query = NoQuery