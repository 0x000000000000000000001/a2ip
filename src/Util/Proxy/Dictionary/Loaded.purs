module Util.Proxy.Dictionary.Loaded where

import Data.Lens (Lens')
import Data.Lens.Record (prop)
import Proem (ᴠ)
import Type.Prelude (Proxy(..))

loaded' = Proxy :: Proxy "loaded"
loaded_ = ᴠ loaded' :: String
_loaded = prop loaded' :: forall a r. Lens' (Record (loaded :: a | r)) a
