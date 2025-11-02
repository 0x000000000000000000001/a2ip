module Util.Proxy.Dictionary.Carrousel where

import Data.Lens (Lens')
import Data.Lens.Record (prop)
import Proem (ᴠ)
import Type.Prelude (Proxy(..))

carrousel' = Proxy :: Proxy "carrousel"
carrousel_ = ᴠ carrousel' :: String
_carrousel = prop carrousel' :: forall a r. Lens' (Record (carrousel :: a | r)) a
