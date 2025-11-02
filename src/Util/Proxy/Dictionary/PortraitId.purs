module Util.Proxy.Dictionary.PortraitId where

import Data.Lens (Lens')
import Data.Lens.Record (prop)
import Proem (ᴠ)
import Type.Prelude (Proxy(..))

portraitId' = Proxy :: Proxy "portraitId"
portraitId_ = ᴠ portraitId' :: String
_portraitId = prop portraitId' :: forall a r. Lens' (Record (portraitId :: a | r)) a
