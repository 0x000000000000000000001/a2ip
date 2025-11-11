module Util.Proxy.Dictionary.TimelinePortraits where

import Data.Lens (Lens')
import Data.Lens.Record (prop)
import Proem (ᴠ)
import Type.Prelude (Proxy(..))

timelinePortraits' = Proxy :: Proxy "timelinePortraits"
timelinePortraits_ = ᴠ timelinePortraits' :: String
_timelinePortraits = prop timelinePortraits' :: ∀ a r. Lens' (Record (timelinePortraits :: a | r)) a
