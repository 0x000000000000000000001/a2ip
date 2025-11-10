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
import Effect.Ref (read, write)
import Halogen (fork, get, kill)

handleHandleDocScroll :: ∀ w i. TimelineM w i Unit
handleHandleDocScroll = do
  state <- get

  for_ state.scrollFork \ref -> do
    maybeForkId <- ʌ $ read ref
    for_ maybeForkId kill

  forkId <- fork do
    ʌ' $ delay $ Milliseconds 150.0
    handleHandleDocScrollEnd

  for_ state.scrollFork \ref ->
    ʌ $ write (Just forkId) ref
