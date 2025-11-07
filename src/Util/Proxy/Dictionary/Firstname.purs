module Util.Proxy.Dictionary.Firstname where

import Data.Lens (Lens')
import Data.Lens.Record (prop)
import Proem (ᴠ)
import Type.Prelude (Proxy(..))

firstname' = Proxy :: Proxy "firstname"
firstname_ = ᴠ firstname' :: String
_firstname = prop firstname' :: ∀ a r. Lens' (Record (firstname :: a | r)) a
