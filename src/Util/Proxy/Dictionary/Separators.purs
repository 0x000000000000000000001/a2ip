module Util.Proxy.Dictionary.Separators where

import Proem (ᴠ)
import Type.Prelude (Proxy(..))

separators' = Proxy :: Proxy "separators"
separators_ = ᴠ separators' :: String
