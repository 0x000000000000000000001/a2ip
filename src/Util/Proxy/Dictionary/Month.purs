module Util.Proxy.Dictionary.Month where

import Proem (ᴠ)
import Type.Prelude (Proxy(..))

month' = Proxy :: Proxy "month"
month_ = ᴠ month' :: String
