module Util.Effect.Timer where

import Prelude
import Effect (Effect)

foreign import data IntervalId :: Type

foreign import setInterval :: Int -> Effect Unit -> Effect IntervalId

foreign import clearInterval :: IntervalId -> Effect Unit
