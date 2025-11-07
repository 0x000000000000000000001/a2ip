module Util.Proxy.Dictionary.Height where

import Data.Lens (Lens')
import Data.Lens.Record (prop)
import Proem (ᴠ)
import Type.Prelude (Proxy(..))

height' = Proxy :: Proxy "height"
height_ = ᴠ height' :: String
_height = prop height' :: ∀ a r. Lens' (Record (height :: a | r)) a
