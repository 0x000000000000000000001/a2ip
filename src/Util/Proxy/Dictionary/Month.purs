module Util.Proxy.Dictionary.Month where

import Data.Lens (Lens')
import Data.Lens.Record (prop)
import Proem (ᴠ)
import Type.Prelude (Proxy(..))

month' = Proxy :: Proxy "month"
month_ = ᴠ month' :: String
_month = prop month' :: ∀ a r. Lens' (Record (month :: a | r)) a
