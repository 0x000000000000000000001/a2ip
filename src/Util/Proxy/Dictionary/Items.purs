module Util.Proxy.Dictionary.Items where

import Proem (ᴠ)
import Type.Prelude (Proxy(..))

items' = Proxy :: Proxy "items"
items_ = ᴠ items' :: String
