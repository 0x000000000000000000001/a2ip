module Util.Proxy.Dictionary.Theme where

import Data.Lens (Lens')
import Data.Lens.Record (prop)
import Proem (ᴠ)
import Type.Prelude (Proxy(..))

theme' = Proxy :: Proxy "theme"
theme_ = ᴠ theme' :: String
_theme = prop theme' :: forall a r. Lens' (Record (theme :: a | r)) a
