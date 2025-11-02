module Util.Proxy.Dictionary.SelectedSeminar where

import Proem (ᴠ)
import Type.Prelude (Proxy(..))

selectedSeminar' = Proxy :: Proxy "selectedSeminar"
selectedSeminar_ = ᴠ selectedSeminar' :: String
