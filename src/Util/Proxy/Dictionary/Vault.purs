module Util.Proxy.Dictionary.Vault where

import Data.Lens (Lens')
import Data.Lens.Record (prop)
import Proem (ᴠ)
import Type.Prelude (Proxy(..))

vault' = Proxy :: Proxy "vault"
vault_ = ᴠ vault' :: String
_vault = prop vault' :: forall a r. Lens' (Record (vault :: a | r)) a
