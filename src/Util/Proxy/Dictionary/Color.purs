module Util.Proxy.Dictionary.Color where

import Data.Lens (Lens')
import Data.Lens.Record (prop)
import Proem (ᴠ)
import Type.Prelude (Proxy(..))

color' = Proxy :: Proxy "color"
color_ = ᴠ color' :: String
_color = prop color' :: forall a r. Lens' (Record (color :: a | r)) a
