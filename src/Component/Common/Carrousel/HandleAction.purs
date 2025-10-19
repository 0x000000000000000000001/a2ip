module Component.Common.Carrousel.HandleAction
  ( handleAction
  ) where

import Proem

import Capability.AppM (AppM)
import Component.Common.Carrousel.Type (Action(..), Output, Slots, State)
import Data.Array (length)
import Halogen (HalogenM, modify_)

handleAction :: Action -> HalogenM State Action Slots Output AppM Unit
handleAction = case _ of 
  GoToPrevious -> 
    modify_ \s -> 
      let newIndex = (s.index - 1 + length s.imageSources) `mod` length s.imageSources
      in s { index = newIndex }
  GoToNext -> 
    modify_ \s -> 
      let newIndex = (s.index + 1) `mod` length s.imageSources
      in s { index = newIndex }
  Receive input ->
    modify_ \s -> s 
      { imageSources = input.imageSources
      , index = s.imageSources /= input.imageSources ? 0 ↔ s.index 
      }