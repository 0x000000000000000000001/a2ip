module Test.Utils.Assert.WithLocation where

import Prelude
import Effect.Unsafe (unsafePerformEffect)

-- | Fonction pure qui force la capture synchrone de la stack trace
foreign import _captureStackTraceSync :: Unit -> String

-- | Version pure qui utilise unsafePerformEffect
captureStackTrace :: Unit -> String
captureStackTrace unit = unsafePerformEffect (pure (_captureStackTraceSync unit))