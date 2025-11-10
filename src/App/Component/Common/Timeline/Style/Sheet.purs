module App.Component.Common.Timeline.Style.Sheet
  ( sheet
  ) where

import Proem (discard)
import App.Component.Common.Timeline.Style.Timeline as Timeline
import App.Component.Common.Timeline.Style.Line as Line
import App.Component.Common.Timeline.Style.Item as Item
import App.Component.Common.Timeline.Style.Items as Items
import App.Component.Common.Timeline.Style.Date as Date
import App.Component.Common.Timeline.Style.Number as Number
import App.Component.Common.Timeline.Style.Pin as Pin
import App.Component.Common.Timeline.Style.DownArrow as DownArrow
import Halogen.HTML (HTML)
import Halogen.HTML.CSS (stylesheet)

sheet :: ∀ w i. HTML w i
sheet = stylesheet do
  Timeline.style
  Line.style
  Date.style
  Items.style
  Item.style
  Pin.style
  DownArrow.style
  Number.style