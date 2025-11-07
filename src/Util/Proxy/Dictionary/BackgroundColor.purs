module Util.Proxy.Dictionary.BackgroundColor where

import Data.Lens (Lens')
import Data.Lens.Record (prop)
import Proem (ᴠ)
import Type.Prelude (Proxy(..))

backgroundColor' = Proxy :: Proxy "backgroundColor"
backgroundColor_ = ᴠ backgroundColor' :: String
_backgroundColor = prop backgroundColor' :: forall a r. Lens' (Record (backgroundColor :: a | r)) a
