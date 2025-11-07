module Util.Proxy.Dictionary.Left where

import Data.Lens (Lens')
import Data.Lens.Record (prop)
import Proem (ᴠ)
import Type.Prelude (Proxy(..))

left' = Proxy :: Proxy "left"
left_ = ᴠ left' :: String
_left = prop left' :: ∀ a r. Lens' (Record (left :: a | r)) a
