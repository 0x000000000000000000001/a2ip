module Util.Proxy.Dictionary.Inner where

import Data.Lens (Lens')
import Data.Lens.Record (prop)
import Proem (ᴠ)
import Type.Prelude (Proxy(..))

inner' = Proxy :: Proxy "inner"
inner_ = ᴠ inner' :: String
_inner = prop inner' :: ∀ a r. Lens' (Record (inner :: a | r)) a
