module Util.Proxy.Dictionary.Timeline where

import Proem (ᴠ)
import Type.Prelude (Proxy(..))

timeline' = Proxy :: Proxy "timeline"
timeline_ = ᴠ timeline' :: String
