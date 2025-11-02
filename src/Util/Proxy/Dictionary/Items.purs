module Util.Proxy.Dictionary.Items where

import Data.Lens (Lens')
import Data.Lens.Record (prop)
import Proem (ᴠ)
import Type.Prelude (Proxy(..))

items' = Proxy :: Proxy "items"
items_ = ᴠ items' :: String
_items = prop items' :: forall a r. Lens' (Record (items :: a | r)) a
