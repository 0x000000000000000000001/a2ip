module Util.Proxy.Dictionary.Portraits where

import Proem (ᴠ)
import Type.Prelude (Proxy(..))

portraits' = Proxy :: Proxy "portraits"
portraits_ = ᴠ portraits' :: String
