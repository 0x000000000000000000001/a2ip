module Util.Proxy.Dictionary.Separators where

import Data.Lens (Lens')
import Data.Lens.Record (prop)
import Proem (ᴠ)
import Type.Prelude (Proxy(..))

separators' = Proxy :: Proxy "separators"
separators_ = ᴠ separators' :: String
_separators = prop separators' :: ∀ a r. Lens' (Record (separators :: a | r)) a
