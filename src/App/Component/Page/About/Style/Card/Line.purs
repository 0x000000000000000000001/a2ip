module App.Component.Page.About.Style.Card.Line
  ( classId
  , classIdWhen
  , style
  ) where

import Proem hiding (top)

import App.Component.Page.About.Type (email, phone, role)
import CSS (star, (&))
import CSS as CSS
import Util.Style (all, before, content, displayInlineBlock, fontSizePct, fontWeightBold, hash9, marginTop, nothing, raw, widthPct, (.&.), (.?), (.|>), (:?))

classId :: String
classId = "wNMB3qHPD"

classIdWhen :: String -> String
classIdWhen = hash9 ◁ (classId <> _)
 
style :: CSS.CSS
style = do
  classId .? do
    marginTop 0.6
    widthPct 75.0
    raw "transition" "background-color 0s; color 0s"

  __role :? do 
    fontWeightBold
    fontSizePct 125.0

  __email :? do
    nothing

  a___before :? do
    content "✉️  "

  __phone :? do
    nothing

  b___before :? do
    content "📞  "

  __allChildren :? do
    displayInlineBlock

  where 
  __allChildren = classId .|> all
  __role = classId .&. classIdWhen (ᴠ role)
  __email = classId .&. classIdWhen (ᴠ email)
  __phone = classId .&. classIdWhen (ᴠ phone)
  a___before = __email & before
  b___before = __phone & before