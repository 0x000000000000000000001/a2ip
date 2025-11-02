module Util.Proxy.Dictionary.Members where

import Proem (ᴠ)
import Type.Prelude (Proxy(..))

members' = Proxy :: Proxy "members"
members_ = ᴠ members' :: String
