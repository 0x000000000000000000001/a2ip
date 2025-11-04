module Util.Proxy.Dictionary.Phase where

import Data.Lens (Lens')
import Data.Lens.Record (prop)
import Proem (ᴠ)
import Type.Prelude (Proxy(..))

phase' = Proxy :: Proxy "phase"
phase_ = ᴠ phase' :: String
_phase = prop phase' :: forall a r. Lens' (Record (phase :: a | r)) a
