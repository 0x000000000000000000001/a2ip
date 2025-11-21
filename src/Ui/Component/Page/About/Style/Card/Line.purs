module Ui.Component.Page.About.Style.Card.Line
  ( line
  , line_
  , staticClass
  , staticClassWhen
  , style
  )
  where

import Proem hiding (div, top)

import CSS ((&))
import CSS as CSS
import DOM.HTML.Indexed (HTMLdiv)
import Data.Symbol (class IsSymbol)
import Halogen.HTML (HTML, Node, div)
import Type.Prelude (Proxy)
import Util.Proxy.Dictionary.Email (email_)
import Util.Proxy.Dictionary.Phone (phone_)
import Util.Proxy.Dictionary.Role (role_)
import Util.Style.Style (all, before, classes, content, displayInlineBlock, fontSizePct, fontWeightBold, marginTop, noCss, raw, refineClass', reflectStaticClass, widthPct, (.&.), (.?), (.|>), (:?))

staticClass :: String
staticClass = reflectStaticClass ι

staticClassWhen :: String -> String
staticClassWhen = refineClass' staticClass
 
style :: CSS.CSS
style = do
  staticClass .? do
    marginTop 0.6
    widthPct 75.0
    raw "transition" "background-color 0s; color 0s"

  __role :? do 
    fontWeightBold
    fontSizePct 125.0

  __email :? do
    noCss

  a___before :? do
    content "✉️  "

  __phone :? do
    noCss

  b___before :? do
    content "📞  "

  __allChildren :? do
    displayInlineBlock

  where 
  __allChildren = staticClass .|> all
  __role = staticClass .&. staticClassWhen role_
  __email = staticClass .&. staticClassWhen email_
  __phone = staticClass .&. staticClassWhen phone_
  a___before = __email & before
  b___before = __phone & before

line :: ∀ sym w i. IsSymbol sym => Proxy sym -> Node HTMLdiv w i
line key props = div ([ classes [staticClass, staticClassWhen $ ᴠ key] ] <> props)

line_ :: ∀ sym w i. IsSymbol sym => Proxy sym -> Array (HTML w i) -> HTML w i
line_ key = line key []