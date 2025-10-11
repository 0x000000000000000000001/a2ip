module Test.Component.Page.Index where

import Proem

import Test.Spec (Spec)

import Test.Component.Page.About.Index as About

spec :: Spec Unit
spec = do
  About.spec