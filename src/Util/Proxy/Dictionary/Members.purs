module Util.Proxy.Dictionary.Members where

import Data.Lens (Lens')
import Data.Lens.Record (prop)
import Proem (ᴠ)
import Type.Prelude (Proxy(..))

members' = Proxy :: Proxy "members"
members_ = ᴠ members' :: String
_members = prop members' :: forall a r. Lens' (Record (members :: a | r)) a
