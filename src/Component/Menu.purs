module Component.Menu
  ( Action
  , Output(..)
  , component
  , foldWidth
  ) where

import Prelude hiding (top, div)

import CSS (Selector, alignItems, alignSelf, backgroundColor, borderRadius, borderRight, boxShadow, color, column, cursor, display, fixed, flex, flexDirection, flexGrow, flexStart, fromString, graytone, height, hover, justifyContent, key, left, margin, marginLeft, minWidth, opacity, padding, position, rem, rgba, solid, top, vh, visibility, white, width, zIndex, (&), (?), (|*))
import CSS as CSS
import CSS.Box (bsColor, shadow)
import CSS.Common (center, visible, hidden)
import CSS.Cursor (pointer)
import CSS.Overflow (overflow)
import CSS.Overflow as Overflow
import Data.NonEmpty (singleton)
import Effect.Aff.Class (class MonadAff)
import Halogen as H
import Halogen.HTML (HTML, div, img, nav, text)
import Halogen.HTML.CSS as HCSS
import Halogen.HTML.Events as HE
import Halogen.HTML.Properties as HP
import Utils (class_, ourRed)

type State = { isUnfold :: Boolean }

data Action = ToggleFolding Boolean

data Output = MenuOutput

foldWidth :: Number
foldWidth = 6.2

unfoldWidth :: Number
unfoldWidth = 3.4 * foldWidth

iconWidth :: Number
iconWidth = 3.2

menuClassName :: String
menuClassName = ".menu"

menuClass :: Selector
menuClass = CSS.fromString menuClassName

logoClassName :: String
logoClassName = menuClassName <> "__logo"

logoClass :: Selector
logoClass = CSS.fromString logoClassName

itemClassName :: String
itemClassName = menuClassName <> "__item"

itemClass :: Selector
itemClass = CSS.fromString itemClassName

itemIconContainerClassName :: String
itemIconContainerClassName = itemIconClassName <> "-container"

itemIconContainerClass :: Selector
itemIconContainerClass = CSS.fromString itemIconContainerClassName

itemIconClassName :: String
itemIconClassName = itemClassName <> "__icon"

itemIconClass :: Selector
itemIconClass = CSS.fromString itemIconClassName

logoStyle :: CSS.CSS
logoStyle = do
  logoClass ? do
    width (rem $ iconWidth * 1.2)
    margin (rem 1.4) (rem 1.0) (rem 1.0) (rem 1.0)
    key (fromString "filter") "invert(1)"
    cursor pointer
    alignSelf center

itemStyle :: CSS.CSS
itemStyle = do
  itemClass ? do
    color (graytone 0.9)
    display flex
    justifyContent center
    alignItems center
    cursor pointer
    padding (rem 0.7) (rem 0.0) (rem 0.7) (rem 0.0)

  hoverSel ? do
    backgroundColor ourRed

  hoverSel |* itemIconContainerClass ? (itemIconContainerBoxShadow 0.22 (-0.10))

  where
  hoverSel = itemClass & hover

itemIconStyle :: CSS.CSS
itemIconStyle = do
  itemIconClass ? do
    margin (rem 0.8) (rem 0.8) (rem 0.8) (rem 0.8)
    key (fromString "filter") "invert(1)"
    key (fromString "object-fit") "contain"

style :: State -> CSS.CSS
style s = do
  menuClass ? do
    width (rem if s.isUnfold then unfoldWidth else foldWidth)
    backgroundColor (rgba 0 0 0 if s.isUnfold then 0.85 else 0.3)
    position fixed
    top (rem 0.0)
    left (rem 0.0)
    height (vh 100.0)
    borderRight solid (rem 0.2) (rgba 0 0 0 0.4)
    zIndex 1000
    display flex
    flexDirection column
    alignItems flexStart
    overflow Overflow.hidden

stylesheet :: forall p i. State -> HTML p i
stylesheet s = HCSS.stylesheet do
  style s
  logoStyle
  itemStyle
  itemIconContainerStyle s
  itemIconStyle

component :: forall q o m. MonadAff m => H.Component q Unit o m
component = H.mkComponent
  { initialState: \_ -> { isUnfold: false }
  , render
  , eval: H.mkEval H.defaultEval { handleAction = handleAction }
  }

handleAction :: forall o m. MonadAff m => Action -> H.HalogenM State Action () o m Unit
handleAction = case _ of
  ToggleFolding bool -> H.modify_ _ { isUnfold = bool }

itemIconContainerBoxShadow :: Number -> Number -> CSS.CSS
itemIconContainerBoxShadow x y = boxShadow $ singleton $ white `bsColor` shadow (rem x) (rem y)

itemIconContainerStyle :: State -> CSS.CSS
itemIconContainerStyle s = do
  itemIconContainerClass ? do
    backgroundColor (rgba 0 0 0 0.2)
    borderRadius (rem 5.0) (rem 5.0) (rem 5.0) (rem 5.0)
    minWidth (rem iconWidth)
    width (rem iconWidth)
    height (rem iconWidth)
    marginLeft (rem $ (foldWidth / 2.0 - iconWidth / 2.0))
    display flex
    justifyContent center
    alignSelf center
    when s.isUnfold $ itemIconContainerBoxShadow 0.12 0.12

render :: forall m. State -> H.ComponentHTML Action () m
render s =
  nav
    [ class_ menuClassName
    , HE.onMouseEnter \_ -> ToggleFolding true
    , HE.onMouseLeave \_ -> ToggleFolding false
    ]
    [ stylesheet s
    , img
        [ class_ logoClassName
        , HP.src "assets/images/logo.png"
        , HP.alt "Logo"
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
    div [ class_ itemClassName ]
      [ div
          [ class_ $ itemIconContainerClassName
          ]
          [ img
              [ class_ itemIconClassName
              , HP.src (fromString "assets/images/component/menu/" <> iconFileName <> ".png")
              , HP.alt label
              ]
          ]
      , div
          [ HCSS.style do
              visibility if s.isUnfold then visible else hidden
              opacity (if s.isUnfold then 1.0 else 0.0)
              flexGrow 1.0
              minWidth (rem unfoldWidth)
              marginLeft (rem 1.4)
          ]
          [ text label ]
      ]
