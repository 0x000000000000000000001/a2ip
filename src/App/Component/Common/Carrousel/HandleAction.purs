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
      let newIndex = (s.slideIndex - 1 + length s.slides) `mod` length s.slides
      in s { slideIndex = newIndex }
  GoToNext -> 
    modify_ \s -> 
      let newIndex = (s.slideIndex + 1) `mod` length s.slides
      in s { slideIndex = newIndex }
  Receive input ->
    modify_ \s -> s 
      { slides = input.slides
      , slideIndex = s.slides /= input.slides ? 0 ↔ s.slideIndex
      }