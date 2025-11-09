module Util.Proxy.Dictionary.Radius where

import Data.Lens (Lens')
import Data.Lens.Record (prop)
import Proem (ᴠ)
import Type.Prelude (Proxy(..))

radius' = Proxy :: Proxy "radius"
radius_ = ᴠ radius' :: String
_radius = prop radius' :: ∀ a r. Lens' (Record (radius :: a | r)) a
