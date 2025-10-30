module App.Component.Page.Seminars.HandleAction
  ( handleAction
  )
  where

import Proem

import App.Component.Page.Seminars.Type (Action(..), Seminar, SeminarsM, day, firstname, lastname, month, theme, title, videoUrl, year)
import App.Util.Capability.Log (error)
import Data.Array (find, (!!))
import Data.Either (Either)
import Data.Int (fromString)
import Data.Maybe (Maybe(..))
import Data.String (trim)
import Effect.Aff.Class (class MonadAff)
import Halogen (get, modify_, put)
import Network.RemoteData (RemoteData(..))
import Util.Google.Sheet (Converter, fetch, seminarsTab)
import Util.Html.Clean (untag)
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
    put Loading
    seminars <- fetchSeminars
    seminars
      ?! (\sems -> do 
        put $ Success 
          { seminars: sems
          , selectedSeminar: sems !! 0 <#> \sem ->
              { seminar: sem
              , openThemeDescriptionModal: false
              }
          }
      )
      ⇿ (\e -> do 
          error $ "Error fetching seminars: " <> e
          put $ Failure e
      )

  OpenThemeDescriptionModal -> modify_ \s -> case s of 
    Success l@{ selectedSeminar: Just sel@{ openThemeDescriptionModal: false } } -> Success $ 
      l { selectedSeminar = Just sel { openThemeDescriptionModal = true } }
    _ -> s

  CloseThemeDescriptionModal -> modify_ \s -> case s of
    Success l@{ selectedSeminar: Just sel@{ openThemeDescriptionModal: true } } -> Success $ 
      l { selectedSeminar = Just sel { openThemeDescriptionModal = false } }
    _ -> s

  DoNothing -> ηι

fetchSeminars :: ∀ m. MonadAff m => m (Either String (Array Seminar))
fetchSeminars = fetch seminarsTab toSeminar

toSeminar :: Converter Seminar
toSeminar getHtmlCell row =
  { title: getHtmlCell title row
  , theme: getHtmlCell theme row
  , firstname: getHtmlCell firstname row
  , lastname: getHtmlCell lastname row
  , date:
      unsafeDate
        ((fromString $ getHtmlCell year row) ??⇒ 1970)
        ((fromString $ getHtmlCell month row) ??⇒ 1)
        ((fromString $ getHtmlCell day row) ??⇒ 1)
  , videoUrl: untag $ trim $ getHtmlCell videoUrl row
  }
