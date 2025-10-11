module Component.Common.PrettyErrorImage.Style.Sheet
  ( sheet
  ) where

import Proem (discard)
import Halogen.HTML (HTML)
import Halogen.HTML.CSS (stylesheet)
import Component.Common.PrettyErrorImage.Style.PrettyErrorImage as PrettyErrorImage
import Component.Common.PrettyErrorImage.Style.QuestionMark as QuestionMark

sheet :: forall p i. HTML p i
sheet = stylesheet do
  QuestionMark.style 
  PrettyErrorImage.style 