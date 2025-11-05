module Util.Module
  ( reflectModuleName
  )
  where

import Data.Unit (Unit)

foreign import reflectModuleName :: Unit -> String