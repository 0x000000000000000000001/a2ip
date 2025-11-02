module App.Component.Page.Seminars.HandleAction
  ( handleAction
  )
  where

import Proem

import App.Component.Page.Seminars.Type (Action(..), Seminar, SeminarsM, _seminars)
import App.Component.Util.Remote (fetchModify)
import Data.Array (find, (!!))
import Data.Int (fromString)
import Data.Maybe (Maybe(..))
import Data.String (trim)
import Halogen (get, modify_)
import Network.RemoteData (RemoteData(..))
import Util.Google.Sheet (Converter)
import Util.Html.Clean (untag)
import Util.Proxy.Dictionary.Day (day')
import Util.Proxy.Dictionary.Firstname (firstname')
import Util.Proxy.Dictionary.Lastname (lastname')
import Util.Proxy.Dictionary.Month (month')
import Util.Proxy.Dictionary.Seminars (seminars')
import Util.Proxy.Dictionary.Theme (theme')
import Util.Proxy.Dictionary.Title (title')
import Util.Proxy.Dictionary.VideoUrl (videoUrl')
import Util.Proxy.Dictionary.Year (year')
import Util.Time (unsafeDate)

handleAction :: Action -> SeminarsM Unit
handleAction = case _ of 
  SelectSeminar seminar -> modify_ \s -> case s of 
    Success l -> Success $ l 
      { selectedSeminar = seminar <#> \sem ->
          { seminar: sem
          , openThemeDescriptionModal: false
          }
      }
    _ -> s

  SelectSeminarByDate date -> do
    state <- get

    case state of
      Success { seminars } -> do
        let seminar = find (\s -> Just s.date == date) seminars
        handleAction $ SelectSeminar seminar
      _ -> ηι

  Load -> do
    fetchModify 
      seminars' 
      _seminars 
      toSeminar
      (\sems ->  
        { seminars: sems
        , selectedSeminar: sems !! 0 <#> \sem ->
            { seminar: sem
            , openThemeDescriptionModal: false
            }
        }
      )

  OpenThemeDescriptionModal -> modify_ \s -> case s of 
    Success l@{ selectedSeminar: Just sel@{ openThemeDescriptionModal: false } } -> 
      Success $ l { selectedSeminar = Just sel { openThemeDescriptionModal = true } }
    _ -> s

  CloseThemeDescriptionModal -> modify_ \s -> case s of
    Success l@{ selectedSeminar: Just sel@{ openThemeDescriptionModal: true } } -> 
      Success $ l { selectedSeminar = Just sel { openThemeDescriptionModal = false } }
    _ -> s

  DoNothing -> ηι

toSeminar :: Converter Seminar
toSeminar get row =
  { title: get title' row
  , theme: get theme' row
  , firstname: get firstname' row
  , lastname: get lastname' row
  , date:
      unsafeDate
        ((fromString $ get year' row) ??⇒ 1970)
        ((fromString $ get month' row) ??⇒ 1)
        ((fromString $ get day' row) ??⇒ 1)
  , videoUrl: untag $ trim $ get videoUrl' row
  }
