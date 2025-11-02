module Util.Proxy.Dictionary.Inner where

import Proem (ᴠ)
import Type.Prelude (Proxy(..))

inner' = Proxy :: Proxy "inner"
inner_ = ᴠ inner' :: String
