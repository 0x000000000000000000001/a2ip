module Util.Proxy.Dictionary.Phone where

import Proem (ᴠ)
import Type.Prelude (Proxy(..))

phone' = Proxy :: Proxy "phone"
phone_ = ᴠ phone' :: String
