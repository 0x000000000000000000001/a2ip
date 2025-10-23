module App.Component.Page.Home.HandleAction
  ( handleAction
  )
  where

import Proem

import App.Component.Page.Home.Type (Action(..), HomeM)
import Data.Maybe (Maybe(..))
import Halogen (modify_)

handleAction :: Action -> HomeM Unit
handleAction = case _ of 
  ShowModal -> modify_ _ { showModal = true }
