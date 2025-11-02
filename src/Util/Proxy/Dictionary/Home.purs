module Util.Proxy.Dictionary.Home where

import Data.Lens (Lens')
import Data.Lens.Record (prop)
import Proem (ᴠ)
import Type.Prelude (Proxy(..))

home' = Proxy :: Proxy "home"
home_ = ᴠ home' :: String
_home = prop home' :: forall a r. Lens' (Record (home :: a | r)) a
