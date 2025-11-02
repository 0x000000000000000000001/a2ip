module Util.Proxy.Dictionary.Section where

import Proem (ᴠ)
import Type.Prelude (Proxy(..))

section' = Proxy :: Proxy "section"
section_ = ᴠ section' :: String
