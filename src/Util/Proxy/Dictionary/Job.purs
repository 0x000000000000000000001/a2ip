module Util.Proxy.Dictionary.Job where

import Proem (ᴠ)
import Type.Prelude (Proxy(..))

job' = Proxy :: Proxy "job"
job_ = ᴠ job' :: String
