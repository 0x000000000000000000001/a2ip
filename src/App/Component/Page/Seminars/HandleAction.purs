module App.Component.Page.Seminars.HandleAction
  ( handleAction
  )
  where

import Proem

import App.Component.Page.Seminars.Type (Action(..), Seminar, SeminarsM, theme, title, firstname, name, day, month, year, videoLink)
import App.Util.Capability.Log (error)
import Data.Either (Either)
import Data.Int (fromString)
import Data.Maybe (Maybe(..))
import Effect.Aff.Class (class MonadAff)
import Halogen (modify_)
import Util.Google.Sheet (Converter, fetch, seminarsTabId)

handleAction :: Action -> SeminarsM Unit
handleAction = case _ of 
  SelectDate seminar -> modify_ _ { selectedSeminar = Just seminar }

  Load -> do
    seminars <- fetchSeminars
    seminars
      ?! (\m -> modify_ _ { seminars = Just m })
      ⇿ (error ◁ ("Error fetching seminars: " <> _))

fetchSeminars :: ∀ m. MonadAff m => m (Either String (Array Seminar))
fetchSeminars = fetch seminarsTabId toSeminar

toSeminar :: Converter Seminar
toSeminar getHtmlCell row =
  { title: getHtmlCell title row
  , theme: getHtmlCell theme row
  , firstname: getHtmlCell firstname row
  , name: getHtmlCell name row
  , day: (fromString $ getHtmlCell day row) ??⇒ 1
  , month: (fromString $ getHtmlCell month row) ??⇒ 1
  , year: (fromString $ getHtmlCell year row) ??⇒ 1970
  , videoLink: getHtmlCell videoLink row
  }
