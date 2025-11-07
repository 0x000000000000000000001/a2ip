module Util.Proxy.Dictionary.Id where

import Data.Lens (Lens')
import Data.Lens.Record (prop)
import Proem (ᴠ)
import Type.Prelude (Proxy(..))

id' = Proxy :: Proxy "id"
id_ = ᴠ id' :: String
_id = prop id' :: forall a r. Lens' (Record (id :: a | r)) a
