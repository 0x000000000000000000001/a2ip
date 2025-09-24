module Test.Utils.Assert ((===), shouldEqualWithLine) where

import Prelude

import Effect.Aff (Aff)
import Control.Monad.Error.Class (throwError)
import Effect.Exception (error)
import Test.Utils.Assert.WithLocation (captureStackTrace)

-- | Version améliorée de shouldEqual qui affiche la ligne source
shouldEqualWithLine :: forall t. Show t => Eq t => t -> t -> Aff Unit
shouldEqualWithLine v1 v2 = do
  when (v1 /= v2) do
    -- Utiliser unsafePerformEffect pour capturer la stack trace synchrone
    let lineInfo = captureStackTrace unit
    let message = show v1 <> " ≠ " <> show v2 <> " (" <> lineInfo <> ")"
    throwError $ error message

-- | Alias simple pour shouldEqual avec un symbole pratique
infixl 1 shouldEqualWithLine as ===
