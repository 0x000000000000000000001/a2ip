module Util.Proxy.Dictionary.Prev where

import Data.Lens (Lens')
import Data.Lens.Record (prop)
import Proem (ᴠ)
import Type.Prelude (Proxy(..))

prev' = Proxy :: Proxy "prev"
prev_ = ᴠ prev' :: String
_prev = prop prev' :: forall a r. Lens' (Record (prev :: a | r)) a
