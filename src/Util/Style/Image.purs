module Util.Style.Image
  ( ObjectFit
  , contain
  , cover
  , fill
  , objectFit
  )
  where

import Proem hiding (bottom, top)

import CSS as CSS
import Util.Style.Style (raw)

data ObjectFit
  = Contain
  | Cover
  | Fill

contain = Contain :: ObjectFit
cover = Cover :: ObjectFit
fill = Fill :: ObjectFit

objectFit :: ObjectFit -> CSS.CSS
objectFit fit = raw "object-fit" $ case fit of
  Contain -> "contain"
  Cover -> "cover"
  _ -> "fill"