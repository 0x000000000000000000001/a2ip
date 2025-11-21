module Ui.Component.Common.Timeline.Style.Sheet
  ( sheet
  ) where

import Proem (discard)
import Ui.Component.Common.Timeline.Style.Timeline as Timeline
import Ui.Component.Common.Timeline.Style.Line as Line
import Ui.Component.Common.Timeline.Style.Item as Item
import Ui.Component.Common.Timeline.Style.Items as Items
import Ui.Component.Common.Timeline.Style.Date as Date
import Ui.Component.Common.Timeline.Style.Number as Number
import Ui.Component.Common.Timeline.Style.Pin as Pin
import Ui.Component.Common.Timeline.Style.DownArrow as DownArrow
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