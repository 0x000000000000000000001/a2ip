module Util.Proxy.Dictionary.Password where

import Data.Lens (Lens')
import Data.Lens.Record (prop)
import Proem (ᴠ)
import Type.Prelude (Proxy(..))

password' = Proxy :: Proxy "password"
password_ = ᴠ password' :: String
_password = prop password' :: ∀ a r. Lens' (Record (password :: a | r)) a
