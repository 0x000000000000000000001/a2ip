module Util.Proxy.Dictionary.VideoRecord where

import Data.Lens (Lens')
import Data.Lens.Record (prop)
import Proem (ᴠ)
import Type.Prelude (Proxy(..))

videoRecord' = Proxy :: Proxy "videoRecord"
videoRecord_ = ᴠ videoRecord' :: String
_videoRecord = prop videoRecord' :: ∀ a r. Lens' (Record (videoRecord :: a | r)) a
