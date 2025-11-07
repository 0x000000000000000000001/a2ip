module Util.Proxy.Dictionary.Right where

import Data.Lens (Lens')
import Data.Lens.Record (prop)
import Proem (ᴠ)
import Type.Prelude (Proxy(..))

right' = Proxy :: Proxy "right"
right_ = ᴠ right' :: String
_right = prop right' :: ∀ a r. Lens' (Record (right :: a | r)) a
