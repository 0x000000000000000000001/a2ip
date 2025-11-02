module Util.Proxy.Dictionary.Seminars where

import Data.Lens (Lens')
import Data.Lens.Record (prop)
import Proem (ᴠ)
import Type.Prelude (Proxy(..))

seminars' = Proxy :: Proxy "seminars"
seminars_ = ᴠ seminars' :: String
_seminars = prop seminars' :: forall a r. Lens' (Record (seminars :: a | r)) a
