module Util.Proxy.Dictionary.When where

import Data.Lens (Lens')
import Data.Lens.Record (prop)
import Proem (ᴠ)
import Type.Prelude (Proxy(..))

when' = Proxy :: Proxy "when"
when_ = ᴠ when' :: String
_when = prop when' :: forall a r. Lens' (Record (when :: a | r)) a
