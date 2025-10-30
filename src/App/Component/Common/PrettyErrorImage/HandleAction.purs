module App.Component.Common.PrettyErrorImage.HandleAction
  ( handleAction
  ) where

import Proem

import App.Component.Common.PrettyErrorImage.Type (Action(..), PrettyErrorImageM, Try(..))
import Data.Maybe (Maybe(..), isJust, maybe)
import Halogen (modify_)

handleAction :: Action -> PrettyErrorImageM Unit
handleAction = case _ of
  HandleError -> modify_ $ \s -> case s of
    { try: Just (FirstTry _) } ->
      s { try = Just 
            (do
              input <- s.input
              sources <- input.sources
              fallback <- sources.fallback
              η $ FallbackTry fallback
            ) ??⇒ StopTrying
        }

    { try: Just (FallbackTry _) } -> 
      s { try = Just StopTrying }

    _ -> s

  Receive i -> modify_ $ \s -> s
    { class_ = i.class_
    , try = 
        s.input
          ?? (\input -> 
            input.sources /= i.sources 
              ? (
                i.sources 
                  ?? (Just ◁ FirstTry ◁ _.first)
                  ⇔ Just StopTrying
              )
              ↔ s.try
          )
          ⇔ (
            i.sources 
              ?? (Just ◁ FirstTry ◁ _.first)
              ⇔ Just StopTrying
          )
    , input = Just i
    }