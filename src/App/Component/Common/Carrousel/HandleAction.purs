module App.Component.Common.Carrousel.HandleAction
  ( handleAction
  ) where

import Proem

import App.Component.Common.Carrousel.Type (Action(..), CarrouselM)
import Data.Array (length)
import Halogen (modify_)

handleAction :: Action -> CarrouselM Unit
handleAction = case _ of 
  GoToPrevious -> 
    modify_ \s -> 
      let newIndex = (s.mediaIndex - 1 + length s.medias) `mod` length s.medias
      in s { mediaIndex = newIndex }
  GoToNext -> 
    modify_ \s -> 
      let newIndex = (s.mediaIndex + 1) `mod` length s.medias
      in s { mediaIndex = newIndex }
  Receive input ->
    modify_ \s -> s 
      { medias = input.medias
      , mediaIndex = s.medias /= input.medias ? 0 ↔ s.mediaIndex
      }