module Util.Proxy.Dictionary.Day where

import Data.Lens (Lens')
import Data.Lens.Record (prop)
import Proem (ᴠ)
import Type.Prelude (Proxy(..))

day' = Proxy :: Proxy "day"
day_ = ᴠ day' :: String
_day = prop day' :: ∀ a r. Lens' (Record (day :: a | r)) a
