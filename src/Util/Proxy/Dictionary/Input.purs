module Util.Proxy.Dictionary.Input where

import Data.Lens (Lens')
import Data.Lens.Record (prop)
import Proem (ᴠ)
import Type.Prelude (Proxy(..))

input' = Proxy :: Proxy "input"
input_ = ᴠ input' :: String
_input = prop input' :: ∀ a r. Lens' (Record (input :: a | r)) a
