module Util.Proxy.Dictionary.Image where

import Proem (ᴠ)
import Type.Prelude (Proxy(..))

image' = Proxy :: Proxy "image"
image_ = ᴠ image' :: String
