module Util.Proxy.Dictionary.Next where

import Data.Lens (Lens')
import Data.Lens.Record (prop)
import Proem (ᴠ)
import Type.Prelude (Proxy(..))

next' = Proxy :: Proxy "next"
next_ = ᴠ next' :: String
_next = prop next' :: forall a r. Lens' (Record (next :: a | r)) a
