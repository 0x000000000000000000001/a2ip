module Component.Common.PrettyErrorImage.Style.PrettyErrorImage
  ( sheet
  ) where

import Prelude

import Halogen.HTML (HTML)
import Halogen.HTML.CSS (stylesheet)
import Component.Common.PrettyErrorImage.Style.PrettyErrorImage as PrettyErrorImage

sheet :: forall p i. HTML p i
sheet = stylesheet do
  PrettyErrorImage.style