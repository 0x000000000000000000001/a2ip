module Util.Proxy.Dictionary.Carrousel where

import Proem (ᴠ)
import Type.Prelude (Proxy(..))

carrousel' = Proxy :: Proxy "carrousel"
carrousel_ = ᴠ carrousel' :: String
