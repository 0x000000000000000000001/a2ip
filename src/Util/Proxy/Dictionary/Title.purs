module Util.Proxy.Dictionary.Title where

import Data.Lens (Lens')
import Data.Lens.Record (prop)
import Proem (ᴠ)
import Type.Prelude (Proxy(..))

title' = Proxy :: Proxy "title"
title_ = ᴠ title' :: String
_title = prop title' :: ∀ a r. Lens' (Record (title :: a | r)) a
