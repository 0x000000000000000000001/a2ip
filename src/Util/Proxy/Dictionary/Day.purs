module Util.Proxy.Dictionary.Day where

import Proem (ᴠ)
import Type.Prelude (Proxy(..))

day' = Proxy :: Proxy "day"
day_ = ᴠ day' :: String
