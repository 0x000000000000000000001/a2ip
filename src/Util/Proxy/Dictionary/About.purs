module Util.Proxy.Dictionary.About where

import Data.Lens (Lens')
import Data.Lens.Record (prop)
import Proem (ᴠ)
import Type.Prelude (Proxy(..))

about' = Proxy :: Proxy "about"
about_ = ᴠ about' :: String
_about = prop about' :: forall a r. Lens' (Record (about :: a | r)) a
