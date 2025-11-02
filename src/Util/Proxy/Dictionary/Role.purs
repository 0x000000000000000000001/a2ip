module Util.Proxy.Dictionary.Role where

import Data.Lens (Lens')
import Data.Lens.Record (prop)
import Proem (ᴠ)
import Type.Prelude (Proxy(..))

role' = Proxy :: Proxy "role"
role_ = ᴠ role' :: String
_role = prop role' :: forall a r. Lens' (Record (role :: a | r)) a
