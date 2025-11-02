module Util.Proxy.Dictionary.About where

import Proem (ᴠ)
import Type.Prelude (Proxy(..))

about' = Proxy :: Proxy "about"
about_ = ᴠ about' :: String
