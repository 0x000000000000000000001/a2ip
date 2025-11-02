module Util.Proxy.Dictionary.Portraits where

import Data.Lens (Lens')
import Data.Lens.Record (prop)
import Proem (ᴠ)
import Type.Prelude (Proxy(..))

portraits' = Proxy :: Proxy "portraits"
portraits_ = ᴠ portraits' :: String
_portraits = prop portraits' :: forall a r. Lens' (Record (portraits :: a | r)) a
