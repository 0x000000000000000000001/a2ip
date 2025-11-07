module Util.Proxy.Dictionary.Year where

import Data.Lens (Lens')
import Data.Lens.Record (prop)
import Proem (ᴠ)
import Type.Prelude (Proxy(..))

year' = Proxy :: Proxy "year"
year_ = ᴠ year' :: String
_year = prop year' :: ∀ a r. Lens' (Record (year :: a | r)) a
