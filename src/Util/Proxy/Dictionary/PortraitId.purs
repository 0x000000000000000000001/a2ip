module Util.Proxy.Dictionary.PortraitId where

import Proem (ᴠ)
import Type.Prelude (Proxy(..))

portraitId' = Proxy :: Proxy "portraitId"
portraitId_ = ᴠ portraitId' :: String
