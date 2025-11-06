module App.Component.Page.Home.HandleAction
  ( handleAction
  )
  where

import Proem

import App.Component.Page.Home.Type (Action(..), HomeM)
import Halogen (modify_)

handleAction :: Action -> HomeM Unit
handleAction = case _ of 
  ShowModal -> modify_ _ { showModal = true }
  HideModal -> modify_ _ { showModal = false }
  DoNothing -> ηι
  InnerClicked -> modify_ \s -> s { innerClicks = s.innerClicks + 1, showModal = true }
  OuterClicked -> modify_ \s -> s { outerClicks = s.outerClicks + 1 }
