module Util.Module
  ( captureCallingModuleName
  , reflectModuleName
  )
  where

import Proem

foreign import captureCallingModuleName :: Unit -> String

reflectModuleName :: String
reflectModuleName = captureCallingModuleName ι