module Util.Proxy.Dictionary.With where

import Data.Lens (Lens')
import Data.Lens.Record (prop)
import Proem (ᴠ)
import Type.Prelude (Proxy(..))

with' = Proxy :: Proxy "with"
with_ = ᴠ with' :: String
_with = prop with' :: ∀ a r. Lens' (Record (with :: a | r)) a
