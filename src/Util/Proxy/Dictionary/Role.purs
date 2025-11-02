module Util.Proxy.Dictionary.Role where

import Proem (ᴠ)
import Type.Prelude (Proxy(..))

role' = Proxy :: Proxy "role"
role_ = ᴠ role' :: String
