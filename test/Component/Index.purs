module Test.Component.Index where

import Proem

import Test.Spec (Spec)

import Test.Component.Page.Index as Page

spec :: Spec Unit
spec = do
  Page.spec