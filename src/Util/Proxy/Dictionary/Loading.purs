module Util.Proxy.Dictionary.Loading where

import Data.Lens (Lens')
import Data.Lens.Record (prop)
import Proem (ᴠ)
import Type.Prelude (Proxy(..))

loading' = Proxy :: Proxy "loading"
loading_ = ᴠ loading' :: String
_loading = prop loading' :: ∀ a r. Lens' (Record (loading :: a | r)) a
