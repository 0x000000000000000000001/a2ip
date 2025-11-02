module Util.Proxy.Dictionary.Date where

import Proem (ᴠ)
import Type.Prelude (Proxy(..))

date' = Proxy :: Proxy "date"
date_ = ᴠ date' :: String
