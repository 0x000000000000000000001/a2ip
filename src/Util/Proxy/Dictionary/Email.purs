module Util.Proxy.Dictionary.Email where

import Proem (ᴠ)
import Type.Prelude (Proxy(..))

email' = Proxy :: Proxy "email"
email_ = ᴠ email' :: String
