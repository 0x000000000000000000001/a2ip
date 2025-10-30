module App.Component.Common.Timeline.Style.Sheet
  ( sheet
  ) where

import Proem (discard)
import App.Component.Common.Timeline.Style.Timeline as Timeline
import App.Component.Common.Timeline.Style.Line as Line
import App.Component.Common.Timeline.Style.Dates as Dates
import App.Component.Common.Timeline.Style.Date as Date
import App.Component.Common.Timeline.Style.Numbers as Numbers
import App.Component.Common.Timeline.Style.Number as Number
import App.Component.Common.Timeline.Style.Pin as Pin
import App.Component.Common.Timeline.Style.DownArrow as DownArrow
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
  DownArrow.style