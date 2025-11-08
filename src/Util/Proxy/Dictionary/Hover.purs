module Util.Proxy.Dictionary.Hover where

import Data.Lens (Lens')
import Data.Lens.Record (prop)
import Proem (ᴠ)
import Type.Prelude (Proxy(..))

hover' = Proxy :: Proxy "hover"
hover_ = ᴠ hover' :: String
_hover = prop hover' :: ∀ a r. Lens' (Record (hover :: a | r)) a
