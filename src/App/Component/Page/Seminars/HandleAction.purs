module App.Component.Page.Seminars.HandleAction
  ( handleAction
  )
  where

import Proem

import App.Component.Page.Seminars.Type (Action(..), Seminar, SeminarsM, Theme(..))
import App.Component.Util.Remote (fetchModify)
import Data.Array (filter, find, (!!))
import Data.DateTime.Instant (toDateTime)
import Data.Int (fromString)
import Data.Lens (_Just, (.~))
import Data.Maybe (Maybe(..))
import Data.String (trim)
import Data.String.Read (read)
import Effect.Now (now)
import Halogen (get, modify_)
import Network.RemoteData (RemoteData(..), _Success)
import Util.Google.Sheet (Converter)
import Util.Html.Clean (untag)
import Util.Proxy.Dictionary.Day (day')
import Util.Proxy.Dictionary.Firstname (firstname')
import Util.Proxy.Dictionary.Lastname (lastname')
import Util.Proxy.Dictionary.Month (month')
import Util.Proxy.Dictionary.OpenThemeDescriptionModal (_openThemeDescriptionModal)
import Util.Proxy.Dictionary.SelectedSeminar (_selectedSeminar)
import Util.Proxy.Dictionary.Seminars (seminars')
import Util.Proxy.Dictionary.Theme (theme')
import Util.Proxy.Dictionary.Title (title')
import Util.Proxy.Dictionary.VideoUrl (videoUrl')
import Util.Proxy.Dictionary.Year (year')
import Util.Time (unsafeDate)

handleAction :: Action -> SeminarsM Unit
handleAction = case _ of 
  SelectSeminar seminar -> modify_ \s -> case s of 
    Success _ -> 
      s # _Success ◁ _selectedSeminar .~ 
        (seminar <#> \sem ->
          { seminar: sem
          , openThemeDescriptionModal: false
          }
        )
    _ -> s

  SelectSeminarByDate date -> do
    state <- get

    case state of
      Success { seminars } -> do
        let seminar = find (\s -> Just s.date == date) seminars
        handleAction $ SelectSeminar seminar
      _ -> ηι

  Load -> do
    currentTime <- ʌ now
    let currentDate = toDate $ toDateTime currentTime

    fetchModify seminars' identity toSeminar
      (\sems_ ->  
        let sems = 
              filter 
              ( \s -> trim s.videoUrl /= "" -- useless
                || s.date >= currentDate -- yet to come
              ) 
              sems_
        in 
          { seminars: sems
          , selectedSeminar: sems !! 0 <#> \sem ->
              { seminar: sem
              , openThemeDescriptionModal: false
              }
          }
      )

  OpenThemeDescriptionModal -> modify_ \s -> case s of 
    Success { selectedSeminar: Just { openThemeDescriptionModal: false } } -> 
      s # _Success ◁ _selectedSeminar ◁ _Just ◁ _openThemeDescriptionModal .~ true
    _ -> s

  CloseThemeDescriptionModal -> modify_ \s -> case s of
    Success { selectedSeminar: Just { openThemeDescriptionModal: true } } -> 
      s # _Success ◁ _selectedSeminar ◁ _Just ◁ _openThemeDescriptionModal .~ false
    _ -> s

  DoNothing -> ηι

toSeminar :: Converter Seminar
toSeminar get row =
  { title: get title' row
  , theme: read (get theme' row) ??⇒ Politics
  , firstname: get firstname' row
  , lastname: get lastname' row
  , date:
      unsafeDate
        ((fromString $ get year' row) ??⇒ 1970)
        ((fromString $ get month' row) ??⇒ 1)
        ((fromString $ get day' row) ??⇒ 1)
  , videoUrl: untag $ trim $ get videoUrl' row
  }
