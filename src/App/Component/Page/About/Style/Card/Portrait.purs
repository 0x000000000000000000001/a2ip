module App.Component.Page.About.Style.Card.Portrait
  ( innerStyle
  , style
  )
  where

import Proem hiding (top)

import App.Component.Common.PrettyErrorImage.Style.QuestionMark as QuestionMark
import App.Component.Common.PrettyErrorImage.Type (Style, defaultStyle)
import CSS (border, pct, rem, solid)
import CSS as CSS
import Data.Lens ((.~))
import Data.Maybe (Maybe(..))
import Util.Proxy.Dictionary.Border (_border)
import Util.Proxy.Dictionary.Color (_color)
import Util.Proxy.Dictionary.Errored (_errored)
import Util.Proxy.Dictionary.Fit (_fit)
import Util.Proxy.Dictionary.Height (_height)
import Util.Proxy.Dictionary.QuestionMark (_questionMark)
import Util.Proxy.Dictionary.When (_when)
import Util.Proxy.Dictionary.Width (_width)
import Util.Style.Image (cover)
import Util.Style.Style (borderRadiusPct50, fill, heightRem, marginTop, raw, red, reflectHashModuleName, textRed, widthRem, (.?), (.|*.), (:?))

statelessClass :: String 
statelessClass = reflectHashModuleName ι

width :: Number
width = 12.0

style :: CSS.CSS
style = do
  statelessClass .? do
    marginTop 0.4

innerStyle :: Style
innerStyle = 
  defaultStyle
    # _fit .~ (Just cover)
    # _width .~ (Just $ rem width)
    # _height .~ (Just $ rem width)
    # _border .~ 
        ( Just 
          { radius: Just $ rem (width / 2.0)
          , size: Just 0.3
          , color: Just red 
          }
        )
    # (_questionMark <<< _when ◁ _errored ◁ _color) .~ (Just textRed)
