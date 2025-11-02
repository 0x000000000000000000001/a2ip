module Util.Proxy.Dictionary.Menu where

import Data.Lens (Lens')
import Data.Lens.Record (prop)
import Proem (ᴠ)
import Type.Prelude (Proxy(..))

menu' = Proxy :: Proxy "menu"
menu_ = ᴠ menu' :: String
_menu = prop menu' :: forall a r. Lens' (Record (menu :: a | r)) a
