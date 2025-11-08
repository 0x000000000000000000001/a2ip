module Util.Proxy.Dictionary.Border where

import Data.Lens (Lens')
import Data.Lens.Record (prop)
import Proem (ᴠ)
import Type.Prelude (Proxy(..))

border' = Proxy :: Proxy "border"
border_ = ᴠ border' :: String
_border = prop border' :: ∀ a r. Lens' (Record (border :: a | r)) a
