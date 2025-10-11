module Test.Component.Page.About.Index where

import Proem

import Test.Spec (Spec)

import Test.Component.Page.About.HandleAction.Index as HandleAction

spec :: Spec Unit
spec = do
  HandleAction.spec