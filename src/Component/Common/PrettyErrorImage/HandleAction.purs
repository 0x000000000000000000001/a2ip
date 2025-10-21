module Component.Common.PrettyErrorImage.HandleAction
  ( handleAction
  ) where

import Proem

import Component.Common.PrettyErrorImage.Type (Action(..), PrettyErrorImageM)
import Halogen (modify_)

handleAction :: Action -> PrettyErrorImageM Unit
handleAction = case _ of
  HandleError -> modify_ $ \s -> s { errorCount = 1 + s.errorCount }
  Receive i -> modify_ $ \s -> s
    { src = i.src
    , fallbackSrc = i.fallbackSrc
    , errorCount = s.src /= i.src || s.fallbackSrc /= i.fallbackSrc ? 0 ↔ s.errorCount
    , class_ = i.class_
    }