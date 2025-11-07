module Util.Proxy.Dictionary.Focus where

import Data.Lens (Lens')
import Data.Lens.Record (prop)
import Proem (ᴠ)
import Type.Prelude (Proxy(..))

focus' = Proxy :: Proxy "focus"
focus_ = ᴠ focus' :: String
_focus = prop focus' :: ∀ a r. Lens' (Record (focus :: a | r)) a
