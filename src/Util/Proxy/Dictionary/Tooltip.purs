module Util.Proxy.Dictionary.Tooltip where

import Data.Lens (Lens')
import Data.Lens.Record (prop)
import Proem (ᴠ)
import Type.Prelude (Proxy(..))

tooltip' = Proxy :: Proxy "tooltip"
tooltip_ = ᴠ tooltip' :: String
_tooltip = prop tooltip' :: ∀ a r. Lens' (Record (tooltip :: a | r)) a
