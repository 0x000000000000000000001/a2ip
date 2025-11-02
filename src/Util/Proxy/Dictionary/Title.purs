module Util.Proxy.Dictionary.Title where

import Proem (ᴠ)
import Type.Prelude (Proxy(..))

title' = Proxy :: Proxy "title"
title_ = ᴠ title' :: String
