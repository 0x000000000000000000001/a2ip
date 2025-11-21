module Ui.Component.Common.Timeline.HandleAction.HandleAction
  ( handleAction
  ) where

import Proem

import Ui.Component.Common.Timeline.HandleAction.HandleHandleDocScroll (handleHandleDocScroll)
import Ui.Component.Common.Timeline.HandleAction.HandleHandleDocScrollEnd (handleHandleDocScrollEnd)
import Ui.Component.Common.Timeline.HandleAction.HandleInitialize (handleInitialize)
import Ui.Component.Common.Timeline.HandleAction.HandleReceive (handleReceive)
import Ui.Component.Common.Timeline.HandleAction.HandleSelectItem (handleSelectItem)
import Ui.Component.Common.Timeline.HandleAction.HandleSelectItemByDate (handleSelectItemByDate)
import Ui.Component.Common.Timeline.Type (Action(..), TimelineM)

handleAction :: ∀ w i. Action w i -> TimelineM w i Unit
handleAction = case _ of
  Initialize -> handleInitialize
  SelectItem item -> handleSelectItem item
  SelectItemByDate date -> handleSelectItemByDate date
  Receive input -> handleReceive input
  HandleDocScroll -> handleHandleDocScroll
  HandleDocScrollEnd -> handleHandleDocScrollEnd
