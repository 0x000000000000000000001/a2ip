module Util.Proxy.Dictionary.Timeline where

import Data.Lens (Lens')
import Data.Lens.Record (prop)
import Proem (ᴠ)
import Type.Prelude (Proxy(..))

timeline' = Proxy :: Proxy "timeline"
timeline_ = ᴠ timeline' :: String
_timeline = prop timeline' :: ∀ a r. Lens' (Record (timeline :: a | r)) a
