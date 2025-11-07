module Util.Proxy.Dictionary.Country where

import Data.Lens (Lens')
import Data.Lens.Record (prop)
import Proem (ᴠ)
import Type.Prelude (Proxy(..))

country' = Proxy :: Proxy "country"
country_ = ᴠ country' :: String
_country = prop country' :: ∀ a r. Lens' (Record (country :: a | r)) a
