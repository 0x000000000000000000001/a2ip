module Util.Proxy.Dictionary.Country where

import Proem (ᴠ)
import Type.Prelude (Proxy(..))

country' = Proxy :: Proxy "country"
country_ = ᴠ country' :: String
