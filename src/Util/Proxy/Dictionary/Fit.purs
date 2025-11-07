module Util.Proxy.Dictionary.Fit where

import Data.Lens (Lens')
import Data.Lens.Record (prop)
import Proem (ᴠ)
import Type.Prelude (Proxy(..))

fit' = Proxy :: Proxy "fit"
fit_ = ᴠ fit' :: String
_fit = prop fit' :: ∀ a r. Lens' (Record (fit :: a | r)) a
