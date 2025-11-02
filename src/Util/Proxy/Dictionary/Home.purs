module Util.Proxy.Dictionary.Home where

import Proem (ᴠ)
import Type.Prelude (Proxy(..))

home' = Proxy :: Proxy "home"
home_ = ᴠ home' :: String
