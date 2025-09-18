module Utils.Style
  ( class_
  , classes
  , deep_
  , _with
  , _with_
  , with_
  , red
  , fontRed
  , loadingGrey
  , _select
  , padding
  , margin
  , nothing
  , raw
  , borderWidth
  , (<?)
  , (|*>)
  , (<&)
  , (<&>)
  , (&>)
  ) where

import Prelude

import CSS (Refinement, Selector)
import CSS as CSS
import CSS.Color (Color, hsl)
import CSS.Selector as CSSS
import Data.Array (fold)
import Data.Maybe (fromMaybe)
import Data.String (Pattern(..), stripPrefix)
import Halogen.HTML as HH
import Halogen.HTML.Properties as HP

red :: Color
red = hsl 353.91 0.8174 0.4725

fontRed :: Color
fontRed = hsl 353.91 0.8174 0.35

loadingGrey :: Color
loadingGrey = hsl 0.0 0.0 0.9

-- | Utility function to set the class attribute on an HTML element.
-- | It automatically removes any "." prefix from the class name.
class_ :: forall r i. String -> HH.IProp (class :: String | r) i
class_ className = HP.class_ $ HH.ClassName $ stripDotPrefixFromClassName className

classes :: forall r i. Array String -> HH.IProp (class :: String | r) i
classes classNames = HP.classes $ HH.ClassName <$> (stripDotPrefixFromClassName <$> classNames)

stripDotPrefixFromClassName :: String -> String
stripDotPrefixFromClassName className = 
  fromMaybe className (stripPrefix (Pattern ".") className)

raw :: String -> String -> CSS.CSS
raw key value = CSS.key (CSS.fromString key) value

nothing :: CSS.CSS
nothing = pure unit
  
padding :: Number -> CSS.CSS
padding p = CSS.padding (CSS.rem p) (CSS.rem p) (CSS.rem p) (CSS.rem p)

margin :: Number -> CSS.CSS
margin m = CSS.margin (CSS.rem m) (CSS.rem m) (CSS.rem m) (CSS.rem m)

borderWidth :: Number -> CSS.CSS
borderWidth w = CSS.key (CSS.fromString "border-width") w

_select :: String -> CSS.CSS -> CSS.CSS
_select sel rs = CSS.select (CSS.fromString $ "." <> stripDotPrefixFromClassName sel) rs

infixr 5 _select as <?

-- | The deep selector composer.
-- | Maps to `sel1 sel2` in CSS.
deep_ :: Selector -> String -> Selector
deep_ a b = CSSS.deep a (CSS.fromString $ "." <> stripDotPrefixFromClassName b)

infix 6 deep_ as |*>

-- | The filter selector composer, adds a filter to a selector.
-- | Maps to something like `sel#filter`, `sel.filter` or `sel:filter` in CSS,
-- | depending on the filter.
_with :: String -> Refinement -> Selector
_with s r = CSSS.with (CSS.fromString $ "." <> stripDotPrefixFromClassName s) r

infix 6 _with as <&

-- | See `with` 
_with_ :: String -> String -> Selector
_with_ s r = _with s (CSS.fromString $ "." <> stripDotPrefixFromClassName r)

infix 6 _with_ as <&>

-- | See `with` 
with_ :: Selector -> String -> Selector
with_ s r = CSSS.with s (CSS.fromString $ "." <> stripDotPrefixFromClassName r)

infix 6 with_ as &>