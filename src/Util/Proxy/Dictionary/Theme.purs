module Util.Proxy.Dictionary.Theme where

import Proem (ᴠ)
import Type.Prelude (Proxy(..))

theme' = Proxy :: Proxy "theme"
theme_ = ᴠ theme' :: String
