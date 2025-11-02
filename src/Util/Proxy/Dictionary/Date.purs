module Util.Proxy.Dictionary.Date where

import Data.Lens (Lens')
import Data.Lens.Record (prop)
import Proem (ᴠ)
import Type.Prelude (Proxy(..))

date' = Proxy :: Proxy "date"
date_ = ᴠ date' :: String
_date = prop date' :: forall a r. Lens' (Record (date :: a | r)) a
