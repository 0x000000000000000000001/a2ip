module Util.Proxy.Dictionary.Year where

import Proem (ᴠ)
import Type.Prelude (Proxy(..))

year' = Proxy :: Proxy "year"
year_ = ᴠ year' :: String
