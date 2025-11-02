module Util.Proxy.Dictionary.VideoUrl where

import Proem (ᴠ)
import Type.Prelude (Proxy(..))

videoUrl' = Proxy :: Proxy "videoUrl"
videoUrl_ = ᴠ videoUrl' :: String
