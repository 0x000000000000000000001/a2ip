module Component.Page.Seminars.HandleAction
  ( handleAction
  ) where

import Proem

import Capability.AppM (AppM)
import Component.Page.Seminars.Type (Action, Slots, State, Output)
import Halogen (HalogenM)

handleAction :: Action -> HalogenM State Action Slots Output AppM Unit
handleAction _ = ηι
