module Component.Common.Separator.HandleAction
  ( handleAction
  )
  where

import Proem

import Component.Common.Separator.Type (Action(..), ComponentM)
import Halogen (modify_)
import Component.Common.Separator.Type (ComponentM)

handleAction :: Action -> ComponentM Unit
handleAction = case _ of  
  Receive input -> modify_ _ 
    { text = input.text
    , loading = input.loading
    }