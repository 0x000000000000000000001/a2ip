module Util.Proxy.Dictionary.Job where

import Data.Lens (Lens')
import Data.Lens.Record (prop)
import Proem (ᴠ)
import Type.Prelude (Proxy(..))

job' = Proxy :: Proxy "job"
job_ = ᴠ job' :: String
_job = prop job' :: forall a r. Lens' (Record (job :: a | r)) a
