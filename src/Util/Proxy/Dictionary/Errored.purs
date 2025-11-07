module Util.Proxy.Dictionary.Errored where

import Data.Lens (Lens')
import Data.Lens.Record (prop)
import Proem (ᴠ)
import Type.Prelude (Proxy(..))

errored' = Proxy :: Proxy "errored"
errored_ = ᴠ errored' :: String
_errored = prop errored' :: ∀ a r. Lens' (Record (errored :: a | r)) a
