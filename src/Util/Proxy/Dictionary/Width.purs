module Util.Proxy.Dictionary.Width where

import Data.Lens (Lens')
import Data.Lens.Record (prop)
import Proem (ᴠ)
import Type.Prelude (Proxy(..))

width' = Proxy :: Proxy "width"
width_ = ᴠ width' :: String
_width = prop width' :: ∀ a r. Lens' (Record (width :: a | r)) a
