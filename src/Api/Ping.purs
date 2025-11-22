module Api.Ping (ping) where

import Proem

import Effect.Aff (Aff)

ping :: Aff String
ping = η "pong"
