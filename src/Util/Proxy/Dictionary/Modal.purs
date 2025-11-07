module Util.Proxy.Dictionary.Modal where

import Data.Lens (Lens')
import Data.Lens.Record (prop)
import Proem (ᴠ)
import Type.Prelude (Proxy(..))

modal' = Proxy :: Proxy "modal"
modal_ = ᴠ modal' :: String
_modal = prop modal' :: ∀ a r. Lens' (Record (modal :: a | r)) a
