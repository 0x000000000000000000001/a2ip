module Util.Proxy.Dictionary.Lastname where

import Data.Lens (Lens')
import Data.Lens.Record (prop)
import Proem (ᴠ)
import Type.Prelude (Proxy(..))

lastname' = Proxy :: Proxy "lastname" 
lastname_ = ᴠ lastname' :: String
_lastname = prop lastname' :: forall a r. Lens' (Record (lastname :: a | r)) a
