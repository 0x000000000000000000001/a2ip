module Util.Proxy.Dictionary.YoutubeVideo where

import Proem (ᴠ)
import Type.Prelude (Proxy(..))

youtubeVideo' = Proxy :: Proxy "youtubeVideo"
youtubeVideo_ = ᴠ youtubeVideo' :: String
