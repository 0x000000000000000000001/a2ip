module Test.Utils.Assert.WithLocation where

import Prelude
import Effect (Effect)
import Effect.Unsafe (unsafePerformEffect)
import Data.Unit (Unit)

-- | Fonction qui retourne la ligne d'assertion actuelle
foreign import getCurrentAssertionLine :: Effect String

-- | Fonction qui capture la ligne au moment de l'appel
foreign import captureLineAtCallSite :: Effect String

-- | Fonction pure qui force la capture synchrone de la stack trace
foreign import _captureStackTraceSync :: Unit -> String

-- | Version pure qui utilise unsafePerformEffect
captureStackTrace :: Unit -> String
captureStackTrace unit = unsafePerformEffect (pure (_captureStackTraceSync unit))