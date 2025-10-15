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
  Receive i -> modify_ $ \s -> s
    { src = i.src
    , fallbackSrc = i.fallbackSrc
    , errorCount = s.src /= i.src || s.fallbackSrc /= i.fallbackSrc ? 0 ↔ s.errorCount
    , class_ = i.class_
    }