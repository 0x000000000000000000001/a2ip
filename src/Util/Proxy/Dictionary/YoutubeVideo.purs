module Util.Proxy.Dictionary.YoutubeVideo where

import Data.Lens (Lens')
import Data.Lens.Record (prop)
import Proem (ᴠ)
import Type.Prelude (Proxy(..))

youtubeVideo' = Proxy :: Proxy "youtubeVideo"
youtubeVideo_ = ᴠ youtubeVideo' :: String
_youtubeVideo = prop youtubeVideo' :: forall a r. Lens' (Record (youtubeVideo :: a | r)) a
