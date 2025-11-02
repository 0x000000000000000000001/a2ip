module Util.Proxy.Dictionary.Lastname where

import Proem (ᴠ)
import Type.Prelude (Proxy(..))

lastname' = Proxy :: Proxy "lastname" 
lastname_ = ᴠ lastname' :: String
