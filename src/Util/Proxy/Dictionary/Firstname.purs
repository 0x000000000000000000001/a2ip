module Util.Proxy.Dictionary.Firstname where

import Proem (ᴠ)
import Type.Prelude (Proxy(..))

firstname' = Proxy :: Proxy "firstname"
firstname_ = ᴠ firstname' :: String
