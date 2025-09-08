module Utils.Style
  ( (?)
  , class_
  , deep
  , with
  , ourRed
  , select
  , (|*)
  , (&)
  ) where

import Prelude

import CSS (Refinement, Selector)
import CSS as CSS
import CSS.Color (Color, hsl)
import CSS.Selector as CSSS
import Data.Maybe (fromMaybe)
import Data.String (Pattern(..), stripPrefix)
import Halogen.HTML as HH
import Halogen.HTML.Properties as HP

ourRed :: Color
ourRed = hsl 353.91 0.8174 0.4725

-- | Utility function to set the class attribute on an HTML element.
-- | It automatically removes any "." prefix from the class name.
class_ :: forall r i. String -> HH.IProp (class :: String | r) i
class_ className = HP.class_ $ HH.ClassName $ stripDotPrefixFromClassName className

stripDotPrefixFromClassName :: String -> String
stripDotPrefixFromClassName className =
  fromMaybe className (stripPrefix (Pattern ".") className)

select :: String -> CSS.CSS -> CSS.CSS
select sel rs = CSS.select (CSS.fromString $ "." <> stripDotPrefixFromClassName sel) rs

infixr 5 select as ?

-- | The deep selector composer.
-- | Maps to `sel1 sel2` in CSS.
deep :: Selector -> String -> Selector
deep a b = CSSS.deep a (CSS.fromString $ "." <> stripDotPrefixFromClassName b)

infix 6 deep as |*

-- | The filter selector composer, adds a filter to a selector.
-- | Maps to something like `sel#filter`, `sel.filter` or `sel:filter` in CSS,
-- | depending on the filter.
with :: String -> Refinement -> Selector
with s r = CSSS.with (CSS.fromString $ "." <> stripDotPrefixFromClassName s) r

infix 6 with as &