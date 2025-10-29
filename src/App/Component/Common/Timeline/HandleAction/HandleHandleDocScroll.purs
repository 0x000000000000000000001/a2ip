module App.Component.Common.Timeline.HandleAction.HandleHandleDocScroll
  ( handleHandleDocScroll
  ) where

import Proem

import App.Component.Common.Timeline.HandleAction.HandleHandleDocScrollEnd (handleHandleDocScrollEnd)
import App.Component.Common.Timeline.Type (TimelineM)
import Data.Foldable (for_)
import Data.Maybe (Maybe(..))
import Data.Time.Duration (Milliseconds(..))
import Effect.Aff (delay)
import Halogen (fork, get, kill, modify_)

handleHandleDocScroll :: TimelineM Unit
handleHandleDocScroll = do
  state <- get
  for_ state.scrollFork kill

  forkId <- fork do
    ʌ' $ delay $ Milliseconds 150.0
    handleHandleDocScrollEnd

  modify_ _ { scrollFork = Just forkId }
