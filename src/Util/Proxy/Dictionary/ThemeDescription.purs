module Util.Proxy.Dictionary.ThemeDescription where

import Proem (ᴠ)
import Type.Prelude (Proxy(..))

themeDescription' = Proxy :: Proxy "themeDescription"
themeDescription_ = ᴠ themeDescription' :: String
