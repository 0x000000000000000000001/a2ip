module Util.Proxy.Dictionary.VideoUrl where

import Data.Lens (Lens')
import Data.Lens.Record (prop)
import Proem (ᴠ)
import Type.Prelude (Proxy(..))

videoUrl' = Proxy :: Proxy "videoUrl"
videoUrl_ = ᴠ videoUrl' :: String
_videoUrl = prop videoUrl' :: ∀ a r. Lens' (Record (videoUrl :: a | r)) a
