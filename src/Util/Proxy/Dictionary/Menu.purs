module Util.Proxy.Dictionary.Menu where

import Proem (ᴠ)
import Type.Prelude (Proxy(..))

menu' = Proxy :: Proxy "menu"
menu_ = ᴠ menu' :: String
