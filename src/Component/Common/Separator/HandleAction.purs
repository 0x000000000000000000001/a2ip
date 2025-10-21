module Component.Common.Separator.HandleAction
  ( handleAction
  )
  where

import Proem

import Component.Common.Separator.Type (Action(..), SeparatorM)
import Halogen (modify_)
import Component.Common.Separator.Type (SeparatorM)

handleAction :: Action -> SeparatorM Unit
handleAction = case _ of  
  Receive input -> modify_ _ 
    { text = input.text
    , loading = input.loading
    }