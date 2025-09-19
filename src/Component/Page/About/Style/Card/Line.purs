module Component.Page.About.Style.Card.Line
  ( classId
  , classIdWhen
  , style
  ) where

import Prelude hiding (top)

import CSS ((&), (?))
import CSS as CSS
import Utils.Style (before, bold, fontSizePct, hash9, marginTop, nothing, raw, widthPct, (.&.), (.?))

classId :: String
classId = "wNMB3qHPD"

classIdWhen :: String -> String
classIdWhen = hash9
 
style :: CSS.CSS
style = do
  classId .? do
    marginTop 0.6
    widthPct 75.0
    raw "transition" "background-color 0s; color 0s"

  __role ? do 
    bold
    fontSizePct 110.0

  __email ? do 
    nothing

  a___before ? do 
    raw "content" "\"✉️  \""

  __phone ? do 
    nothing

  b___before ? do 
    raw "content" "\"📞  \""

  where 
  __role = classId .&. classIdWhen "role"
  __email = classId .&. classIdWhen "email"
  __phone = classId .&. classIdWhen "phone"
  a___before = __email & before
  b___before = __phone & before 