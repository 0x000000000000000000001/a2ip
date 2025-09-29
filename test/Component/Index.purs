module Test.Component.Index where

import Prelude

import Test.Spec (Spec)

import Test.Component.Page.Index as Page

spec :: Spec Unit
spec = do
  Page.spec