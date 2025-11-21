module Ui.Component.Common.Separator.HandleAction
  ( handleAction
  )
  where

import Proem

import Ui.Component.Common.Separator.Type (Action(..), SeparatorM)
import Halogen (modify_)

handleAction :: Action -> SeparatorM Unit
handleAction = case _ of  
  Receive input -> modify_ _ { input = input }