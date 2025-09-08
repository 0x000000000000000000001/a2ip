module Component.Menu.Style.Sheet
  ( sheet
  ) where

import Component.Menu.Style.Logo as Logo

sheet :: forall p i. State -> HTML p i
sheet s = HCSS.stylesheet do
  style s
  Logo.style
  itemStyle
  itemIconContainerStyle s
  itemIconStyle