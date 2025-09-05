module Main (main) where

import Prelude hiding (div)

import CSS (StyleM, backgroundColor, color, em, fontSize, fromInt, margin, minHeight, padding, px, vh, white)
import Effect (Effect)
import Effect.Aff (launchAff_)
import Effect.Aff.Class (class MonadAff)
import Halogen as H
import Halogen.Aff (awaitBody)
import Halogen.HTML (HTML, div, text)
import Halogen.HTML.CSS (style)
import Halogen.VDom.Driver (runUI)

appStyles :: StyleM Unit
appStyles = do
  backgroundColor (fromInt 0xFF0000) 
  minHeight (vh 100.0)
  padding (px 20.0) (px 20.0) (px 20.0) (px 20.0)
  color white
  margin (px 0.0) (px 0.0) (px 0.0) (px 0.0)
  fontSize (em 1.2)

component :: forall m. MonadAff m => H.Component (HTML Void) Unit Unit m
component = H.mkComponent
  { initialState: \_ -> unit
  , render: \_ -> view
  , eval: H.mkEval H.defaultEval
  }
  where 
    view =
      div
        [ style appStyles ]
        [ text "Coucou Adèle, ma chérie que j'aime !" ]

main :: Effect Unit
main = launchAff_ do
  body <- awaitBody
  void (runUI component unit body)
