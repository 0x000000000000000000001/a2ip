module Ui.Component.Common.PrettyErrorImage.Style.Sheet
  ( sheet
  ) where

import Ui.Component.Common.PrettyErrorImage.Style.PrettyErrorImage as PrettyErrorImage
import Ui.Component.Common.PrettyErrorImage.Style.QuestionMark as QuestionMark
import Ui.Component.Common.PrettyErrorImage.Style.Image as Image
import Ui.Component.Common.PrettyErrorImage.Type (State)
import Halogen.HTML (HTML)
import Halogen.HTML.CSS (stylesheet)
import Proem (discard)

sheet :: ∀ w i. State -> HTML w i
sheet s = stylesheet do
  QuestionMark.style s
  PrettyErrorImage.style s
  Image.style s