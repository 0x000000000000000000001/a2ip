module Util.Proxy.Dictionary.Collaborators where

import Data.Lens (Lens')
import Data.Lens.Record (prop)
import Proem (ᴠ)
import Type.Prelude (Proxy(..))

collaborators' = Proxy :: Proxy "collaborators"
collaborators_ = ᴠ collaborators' :: String
_collaborators = prop collaborators' :: ∀ a r. Lens' (Record (collaborators :: a | r)) a
