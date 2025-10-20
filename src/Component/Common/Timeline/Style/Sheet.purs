module Component.Common.Timeline.Style.Sheet
  ( sheet
  ) where

import Proem (discard)
import Component.Common.Timeline.Style.Timeline as Timeline
import Component.Common.Timeline.Style.Line as Line
import Component.Common.Timeline.Style.Dates as Dates
import Component.Common.Timeline.Style.Date as Date
import Component.Common.Timeline.Style.Numbers as Numbers
import Component.Common.Timeline.Style.Number as Number
import Component.Common.Timeline.Style.Pin as Pin
import Halogen.HTML (HTML)
import Halogen.HTML.CSS (stylesheet)

sheet :: ∀ p i. HTML p i
sheet = stylesheet do
  Timeline.style
  Line.style
  Dates.style
  Date.style
  Numbers.style
  Number.style
  Pin.style