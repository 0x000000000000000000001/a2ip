module Ui.Component.Page.Seminars.Style.Timeline.Label.Portrait
  ( prettyErrorImageStyle
  , staticClass
  )
  where

import Proem hiding (top)

import Ui.Component.Common.PrettyErrorImage.Type (Style, defaultStyle)
import Ui.Component.Util.Type (Size(..))
import Color (white)
import Data.Maybe (Maybe(..))
import Util.Style.Image (cover)
import Util.Style.Style (reflectStaticClass)

staticClass :: String
staticClass = reflectStaticClass ι

prettyErrorImageStyle :: Style
prettyErrorImageStyle = 
  defaultStyle 
    { fit = Just cover
    , width = Just $ Rem 4.0
    , height = Just $ Rem 4.0
    , border = 
        { radius: Just $ Pct 50.0
        , color: Just white
        , width: Just 0.16
        }
    , questionMark = 
        { width: Just $ Pct 60.0
        , when: 
            { errored: 
                { color: Nothing
                }
            }
        }
    }