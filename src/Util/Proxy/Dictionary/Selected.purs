module Util.Proxy.Dictionary.Selected where

import Data.Lens (Lens')
import Data.Lens.Record (prop)
import Proem (ᴠ)
import Type.Prelude (Proxy(..))

selected' = Proxy :: Proxy "selected"
selected_ = ᴠ selected' :: String
_selected = prop selected' :: forall a r. Lens' (Record (selected :: a | r)) a
