module App.Component.Page.Seminars.HandleAction
  ( handleAction
  )
  where

import Proem

import App.Component.Common.Timeline.Type (Date(..))
import App.Component.Page.Seminars.Type (Action(..), Seminar, SeminarsM, theme, title, firstname, lastname, day, month, year, videoLink)
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
  
fetchSeminars :: ∀ m. MonadAff m => m (Either String (Array Seminar))
fetchSeminars = fetch seminarsTab toSeminar

toSeminar :: Converter Seminar
toSeminar getHtmlCell row =
  { title: getHtmlCell title row
  , theme: getHtmlCell theme row
  , firstname: getHtmlCell firstname row
  , lastname: getHtmlCell lastname row
  , date: Date
      { day: (fromString $ getHtmlCell day row) ??⇒ 1
      , month: (fromString $ getHtmlCell month row) ??⇒ 1
      , year: (fromString $ getHtmlCell year row) ??⇒ 1970
      }
  , videoLink: untag $ trim $ getHtmlCell videoLink row
  }
