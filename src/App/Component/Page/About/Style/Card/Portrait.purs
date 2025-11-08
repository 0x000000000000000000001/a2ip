module App.Component.Page.About.Style.Card.Portrait
  ( innerStyle
  , staticClass
  , style
  )
  where

import Proem hiding (top)

import App.Component.Common.PrettyErrorImage.Type (Style, defaultStyle)
import App.Component.Util.Type (Size(..))
import CSS as CSS
import Data.Lens ((.~))
import Data.Maybe (Maybe(..))
import Util.Proxy.Dictionary.Border (_border)
import Util.Proxy.Dictionary.Color (_color)
import Util.Proxy.Dictionary.Errored (_errored)
import Util.Proxy.Dictionary.Fit (_fit)
import Util.Proxy.Dictionary.Height (_height)
import Util.Proxy.Dictionary.Hover (_hover)
import Util.Proxy.Dictionary.QuestionMark (_questionMark)
import Util.Proxy.Dictionary.When (_when)
import Util.Proxy.Dictionary.Width (_width)
import Util.Proxy.Dictionary.With (_with)
import Util.Style.Image (cover)
import Util.Style.Style (marginTop, red, reflectStaticClass, textRed, (.?))

staticClass :: String 
staticClass = reflectStaticClass ι

width :: Number
width = 12.0

style :: CSS.CSS
style = do
  staticClass .? do
    marginTop 0.4

innerStyle :: Style
innerStyle = 
  defaultStyle
    # _fit .~ Just cover
    # _width .~ (Just $ Rem width)
    # _height .~ (Just $ Rem width)
    # _border .~ 
        Just 
          { radius: Just $ Pct 50.0
          , width: Just 0.3
          , color: Just red 
          }
    # _questionMark ◁ _when ◁ _errored ◁ _color .~ Just textRed
    # _with ◁ _hover ◁ _border .~ 
        Just 
          { radius: Just $ Rem 1.0
          , width: Nothing
          , color: Nothing
          }
