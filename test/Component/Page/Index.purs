module Test.Component.Page.Index where

import Prelude

import Test.Spec (Spec)

import Test.Component.Page.About.Index as About

spec :: Spec Unit
spec = do
  About.spec