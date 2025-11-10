module App.Component.Common.Timeline.HandleAction.HandleAction
  ( handleAction
  ) where

import Proem

import App.Component.Common.Timeline.HandleAction.HandleHandleDocScroll (handleHandleDocScroll)
import App.Component.Common.Timeline.HandleAction.HandleHandleDocScrollEnd (handleHandleDocScrollEnd)
import App.Component.Common.Timeline.HandleAction.HandleInitialize (handleInitialize)
import App.Component.Common.Timeline.HandleAction.HandleReceive (handleReceive)
import App.Component.Common.Timeline.HandleAction.HandleSelectItem (handleSelectItem)
import App.Component.Common.Timeline.HandleAction.HandleSelectItemByDate (handleSelectItemByDate)
import App.Component.Common.Timeline.Type (Action(..), TimelineM)

handleAction :: ∀ w i. Action w i -> TimelineM w i Unit
handleAction = case _ of
  Initialize -> handleInitialize
  SelectItem item -> handleSelectItem item
  SelectItemByDate date -> handleSelectItemByDate date
  Receive input -> handleReceive input
  HandleDocScroll -> handleHandleDocScroll
  HandleDocScrollEnd -> handleHandleDocScrollEnd
