module Util.Proxy.Dictionary.Seminars where

import Proem (ᴠ)
import Type.Prelude (Proxy(..))

seminars' = Proxy :: Proxy "seminars"
seminars_ = ᴠ seminars' :: String
