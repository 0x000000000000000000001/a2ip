module App.Component.Page.Seminars.HandleAction
  ( handleAction
  )
  where

import Proem

import App.Component.Page.Seminars.Type (Action(..), Seminar, SeminarsM, theme, title, firstname, lastname, day, month, year, videoUrl)
import App.Util.Capability.Log (error)
import Data.Array (find, (!!))
import Data.Either (Either)
import Data.Int (fromString)
import Data.Maybe (Maybe(..))
import Data.String (trim)
import Effect.Aff.Class (class MonadAff)
import Halogen (get, modify_)
import Util.Google.Sheet (Converter, fetch, seminarsTab)
import Util.Html.Clean (untag)
import Util.Time (unsafeDate)

handleAction :: Action -> SeminarsM Unit
handleAction = case _ of 
  SelectSeminar seminar -> modify_ _ { selectedSeminar = seminar }

  SelectSeminarByDate date -> do
    state <- get
    let seminars = state.seminars ??⇒ []
        seminar = find (\s -> Just s.date == date) seminars
    handleAction $ SelectSeminar seminar

  Load -> do
    seminars <- fetchSeminars
    seminars
      ?! (\m -> do 
        modify_ _ { seminars = Just m }
        handleAction $ SelectSeminar $ m !! 0
      )
      ⇿ (error ◁ ("Error fetching seminars: " <> _))

  OpenThemeDescriptionModal -> modify_ _ { openThemeDescriptionModal = true }

  CloseThemeDescriptionModal -> modify_ _ { openThemeDescriptionModal = false }

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
