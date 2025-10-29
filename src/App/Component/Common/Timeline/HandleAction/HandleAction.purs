module App.Component.Common.Timeline.HandleAction.HandleAction
  ( handleAction
  ) where

import Proem

import App.Component.Common.Timeline.HandleAction.HandleHandleDocScroll (handleHandleDocScroll)
import App.Component.Common.Timeline.HandleAction.HandleHandleDocScrollEnd (handleHandleDocScrollEnd)
import App.Component.Common.Timeline.HandleAction.HandleInitialize (handleInitialize)
import App.Component.Common.Timeline.HandleAction.HandleReceive (handleReceive)
import App.Component.Common.Timeline.HandleAction.HandleSelectDate (handleSelectDate)
import App.Component.Common.Timeline.Type (Action(..), TimelineM)

handleAction :: Action -> TimelineM Unit
handleAction = case _ of
  Initialize -> handleInitialize
  SelectDate date -> handleSelectDate date
  Receive input -> handleReceive input
  HandleDocScroll -> handleHandleDocScroll
  HandleDocScrollEnd -> handleHandleDocScrollEnd
