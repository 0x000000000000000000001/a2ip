module Util.Proxy.Dictionary.Incorrect where

import Data.Lens (Lens')
import Data.Lens.Record (prop)
import Proem (ᴠ)
import Type.Prelude (Proxy(..))

incorrect' = Proxy :: Proxy "incorrect"
incorrect_ = ᴠ incorrect' :: String
_incorrect = prop incorrect' :: forall a r. Lens' (Record (incorrect :: a | r)) a
