module Component.Page.Seminars.Style.Sheet
  ( sheet
  ) where

import Proem (discard)
import Halogen.HTML (HTML)
import Halogen.HTML.CSS (stylesheet)
import Component.Page.Seminars.Style.DateContent as DateContent
import Component.Page.Seminars.Style.Seminars as Seminars
import Component.Page.Seminars.Style.Timeline as Timeline

sheet :: ∀ p i. HTML p i
sheet = stylesheet do
  DateContent.style  
  Seminars.style  
  Timeline.style  