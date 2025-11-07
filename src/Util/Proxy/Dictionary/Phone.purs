module Util.Proxy.Dictionary.Phone where

import Data.Lens (Lens')
import Data.Lens.Record (prop)
import Proem (ᴠ)
import Type.Prelude (Proxy(..))

phone' = Proxy :: Proxy "phone"
phone_ = ᴠ phone' :: String
_phone = prop phone' :: ∀ a r. Lens' (Record (phone :: a | r)) a
