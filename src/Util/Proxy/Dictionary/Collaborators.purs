module Util.Proxy.Dictionary.Collaborators where

import Proem (ᴠ)
import Type.Prelude (Proxy(..))

collaborators' = Proxy :: Proxy "collaborators"
collaborators_ = ᴠ collaborators' :: String
