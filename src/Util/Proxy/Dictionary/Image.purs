module Util.Proxy.Dictionary.Image where

import Data.Lens (Lens')
import Data.Lens.Record (prop)
import Proem (ᴠ)
import Type.Prelude (Proxy(..))

image' = Proxy :: Proxy "image"
image_ = ᴠ image' :: String
_image = prop image' :: ∀ a r. Lens' (Record (image :: a | r)) a
