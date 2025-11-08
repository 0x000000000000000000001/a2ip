module App.Component.Common.PrettyErrorImage.Style.Sheet
  ( sheet
  ) where

import App.Component.Common.PrettyErrorImage.Style.PrettyErrorImage as PrettyErrorImage
import App.Component.Common.PrettyErrorImage.Style.QuestionMark as QuestionMark
import App.Component.Common.PrettyErrorImage.Style.Image as Image
import App.Component.Common.PrettyErrorImage.Type (State)
import Halogen.HTML (HTML)
import Halogen.HTML.CSS (stylesheet)
import Proem (discard)

sheet :: ∀ w i. State -> HTML w i
sheet s = stylesheet do
  QuestionMark.style s
  PrettyErrorImage.style s
  Image.style s