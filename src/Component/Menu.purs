module Component.Menu
  ( Action
  , Output(..)
  , State
  , component
  , handleAction
  , itemLogoStyles2
  , menuItemStyles
  , foldWidth
  )
  where

import Prelude hiding (top, div)

import CSS (StyleM, alignItems, alignSelf, backgroundColor, borderRadius, borderRight, color, column, cursor, display, fixed, flex, flexDirection, flexGrow, flexStart, fromString, graytone, height, justifyContent, key, left, margin, marginLeft, minWidth, opacity, padding, position, px, rem, rgba, solid, top, vh, visibility, width, zIndex)
import CSS.Common (center, hidden, visible)
import CSS.Cursor (pointer)
import Effect.Aff.Class (class MonadAff)
import Halogen as H
import Halogen.HTML (HTML, div, img, nav, text)
import Halogen.HTML.CSS (style)
import Halogen.HTML.Events as HE
import Halogen.HTML.Properties as HP

type State = { isUnfold :: Boolean }

data Action = ToggleFolding Boolean

data Output = MenuOutput

foldWidth :: Number
foldWidth = 6.2

iconWidth :: Number
iconWidth = 1.6

styles :: Boolean -> StyleM Unit
styles unfold = do
  width (rem $ foldWidth * if unfold then 4.0 else 1.0)
  backgroundColor (rgba 0 0 0 if unfold then 0.85 else 0.3)
  position fixed
  top (rem 0.0)
  left (rem 0.0)
  height (vh 100.0)
  borderRight solid (px 2.0) (rgba 0 0 0 0.3)
  zIndex 1000
  display flex
  flexDirection column
  alignItems flexStart

logoStyles :: StyleM Unit
logoStyles = do
  width (px 64.0)
  margin (rem 1.4) (rem 1.0) (rem 1.0) (rem 1.0)
  key (fromString "filter") "invert(1)"
  cursor pointer
  
menuItemStyles :: StyleM Unit
menuItemStyles = do
  color (graytone 0.9)
  display flex
  justifyContent center
  alignItems center
  cursor pointer

component :: forall q o m. MonadAff m => H.Component q Unit o m
component = H.mkComponent
  { initialState: \_ -> { isUnfold: false }
  , render: render
  , eval: H.mkEval H.defaultEval { handleAction = handleAction }
  }

handleAction :: forall o m. MonadAff m => Action -> H.HalogenM State Action () o m Unit
handleAction = case _ of
  ToggleFolding bool -> H.modify_ _ { isUnfold = bool }

itemLogoStyles :: StyleM Unit
itemLogoStyles = do
  backgroundColor (rgba 255 255 255 0.4)
  padding (rem 1.0) (rem 1.0) (rem 1.0) (rem 1.0)
  borderRadius (rem 5.0) (rem 5.0) (rem 5.0) (rem 5.0)
  minWidth (rem iconWidth)
  width (rem iconWidth)
  height (rem iconWidth)
  marginLeft (rem $ (foldWidth - iconWidth) / 2.0)
  key (fromString "filter") "invert(1)"
  display flex
  justifyContent center
  alignSelf center

itemLogoStyles2 :: StyleM Unit
itemLogoStyles2 = do
  key (fromString "object-fit") "contain"

render :: forall m. State -> H.ComponentHTML Action () m
render state =
  nav
    [ style $ styles state.isUnfold
    , HE.onMouseEnter \_ -> ToggleFolding true
    , HE.onMouseLeave \_ -> ToggleFolding false
    ]
    [ img 
      [ HP.src "assets/images/logo.png"
      , HP.alt "Logo"
      , style logoStyles
      ]
    , item "Accueil" "home"
    , item "Bureau et collaborateurs" "armchair"
    , item "Adhésions" "writing"
    , item "Séminaires" "micro"
    , item "Colloques" "micro-2"
    , item "Archives" "archive"
    , item "Publications des membres" "book"
    , item "Contact et mentions légales" "contact"
    ]
  where
    item :: forall w i. String -> String -> HTML w i
    item label iconFileName =
      div 
        [ style menuItemStyles ] 
        [ div 
          [ style itemLogoStyles] 
          [
            img 
            [ HP.src (fromString "assets/images/component/menu/" <> iconFileName <> ".png")
            , HP.alt label 
            , style itemLogoStyles2
            ]
          ]
        , div [ style do
            visibility if state.isUnfold then visible else hidden
            opacity (if state.isUnfold then 1.0 else 0.0)
            flexGrow 1.0
          ] [ text label ]
        ]
