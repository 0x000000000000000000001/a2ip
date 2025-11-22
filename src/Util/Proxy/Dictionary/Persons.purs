module Util.Proxy.Dictionary.Persons where

import Data.Lens (Lens')
import Data.Lens.Record (prop)
import Proem (ᴠ)
import Type.Prelude (Proxy(..))

persons' = Proxy :: Proxy "persons"
persons_ = ᴠ persons' :: String
_persons = prop persons' :: ∀ a r. Lens' (Record (persons :: a | r)) a
