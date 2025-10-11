module Util.Env
  ( isNode
  , isBrowser
  ) where

import Proem

foreign import isNode :: Boolean

isBrowser :: Boolean
isBrowser = not isNode
