module Utils.Style
  ( class_
  , classes
  , deep
  , with
  , with_
  , ourRed
  , ourFontRed
  , select
  , padding
  , margin
  , nothing
  , raw
  , borderWidth
  , (<?)
  , (|*>)
  , (<&)
  , (<&>)
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

ourRed :: Color
ourRed = hsl 353.91 0.8174 0.4725

ourFontRed :: Color
ourFontRed = hsl 353.91 0.8174 0.35

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

select :: String -> CSS.CSS -> CSS.CSS
select sel rs = CSS.select (CSS.fromString $ "." <> stripDotPrefixFromClassName sel) rs

infixr 5 select as <?

-- | The deep selector composer.
-- | Maps to `sel1 sel2` in CSS.
deep :: Selector -> String -> Selector
deep a b = CSSS.deep a (CSS.fromString $ "." <> stripDotPrefixFromClassName b)

infix 6 deep as |*>

-- | The filter selector composer, adds a filter to a selector.
-- | Maps to something like `sel#filter`, `sel.filter` or `sel:filter` in CSS,
-- | depending on the filter.
with :: String -> Refinement -> Selector
with s r = CSSS.with (CSS.fromString $ "." <> stripDotPrefixFromClassName s) r

infix 6 with as <&

-- | See `with` 
with_ :: String -> String -> Selector
with_ s r = with s (CSS.fromString $ "." <> stripDotPrefixFromClassName r)

infix 6 with_ as <&>