module App.Component.Common.PrettyErrorImage.HandleAction
  ( handleAction
  ) where

import Proem

import App.Component.Common.PrettyErrorImage.Type (Action(..), PrettyErrorImageM, Try(..))
import Halogen (modify_)

handleAction :: ∀ u. Action u -> PrettyErrorImageM u Unit
handleAction = case _ of
  HandleError -> modify_ $ \s -> case s of
    { try: FirstTry _ } ->
      s { try =
            s.input.sources.fallback
              ?? FallbackTry
              ⇔ StopTrying
        }

    { try: FallbackTry _ } -> 
      s { try = StopTrying }

    _ -> s

  Receive i -> modify_ $ \s -> 
    s { input = i 
      , try = 
          s.input.sources /= i.sources 
            ? FirstTry i.sources.first
            ↔ s.try
      }