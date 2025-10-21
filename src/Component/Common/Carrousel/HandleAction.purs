module Component.Common.Carrousel.HandleAction
  ( handleAction
  ) where

import Proem

import Component.Common.Carrousel.Type (Action(..), CarrouselM)
import Data.Array (length)
import Halogen (modify_)

handleAction :: Action -> CarrouselM Unit
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