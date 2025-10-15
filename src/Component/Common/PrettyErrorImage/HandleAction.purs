module Component.Common.PrettyErrorImage.HandleAction
  ( handleAction
  ) where

import Proem

import Capability.AppM (AppM)
import Component.Common.PrettyErrorImage.Type (State, Slots, Action(..), Output)
import Halogen (HalogenM, modify_)

handleAction :: Action -> HalogenM State Action Slots Output AppM Unit
handleAction = case _ of
  HandleError -> modify_ $ \s -> s { errorCount = 1 + s.errorCount }
  Receive input -> modify_ $ \s -> s
    { src = input.src
    , fallbackSrc = input.fallbackSrc
    , errorCount = s.src /= input.src || s.fallbackSrc /= input.fallbackSrc ? 0 ↔ s.errorCount
    , class_ = input.class_
    }