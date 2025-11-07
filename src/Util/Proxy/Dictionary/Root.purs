module Util.Proxy.Dictionary.Root where

import Data.Lens (Lens')
import Data.Lens.Record (prop)
import Proem (ᴠ)
import Type.Prelude (Proxy(..))

root' = Proxy :: Proxy "root"
root_ = ᴠ root' :: String
_root = prop root' :: forall a r. Lens' (Record (root :: a | r)) a
