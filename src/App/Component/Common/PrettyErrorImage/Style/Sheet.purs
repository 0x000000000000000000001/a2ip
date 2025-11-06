module App.Component.Common.PrettyErrorImage.Style.Sheet
  ( sheet
  ) where

import Proem (discard)
import Halogen.HTML (HTML)
import Halogen.HTML.CSS (stylesheet)
import App.Component.Common.PrettyErrorImage.Style.PrettyErrorImage as PrettyErrorImage
import App.Component.Common.PrettyErrorImage.Style.QuestionMark as QuestionMark

sheet :: ∀ w i. HTML w i
sheet = stylesheet do
  QuestionMark.style 
  PrettyErrorImage.style 