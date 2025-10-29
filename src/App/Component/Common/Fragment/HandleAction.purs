module App.Component.Common.Fragment.HandleAction
  ( handleAction
  ) where

import Proem

import App.Component.Common.Fragment.Type (Action(..), FragmentM)
import Halogen (put)

handleAction :: ∀ w i. Action w i -> FragmentM w i Unit
handleAction = case _ of
  Receive i -> put i