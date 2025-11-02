module Util.Proxy.Dictionary.Modal where

import Proem (ᴠ)
import Type.Prelude (Proxy(..))

modal' = Proxy :: Proxy "modal"
modal_ = ᴠ modal' :: String
