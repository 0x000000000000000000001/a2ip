module Component.Router.Router where

import Prelude hiding (div)

import Data.Maybe (Maybe(..))
import Effect.Aff.Class (class MonadAff)
import Halogen as H
import Halogen.HTML (div, text)
import Component.Router.Route (Route(..))

type State = { route :: Route }

data Action

data Query a = Navigate Route a

component :: forall i o m. MonadAff m => H.Component Query i o m
component = H.mkComponent
  { initialState: const { route: Home }
  , render
  , eval: H.mkEval H.defaultEval 
      { handleQuery = handleQuery
      }
  }

handleQuery :: forall a o m. MonadAff m => Query a -> H.HalogenM State Action () o m (Maybe a)
handleQuery = case _ of
  Navigate route' a -> do
    H.modify_ _ { route = route' }
    pure (Just a)

render :: forall m. State -> H.ComponentHTML Action () m
render { route } =
  div []
    [ renderRoute route ]

renderRoute :: forall w i. Route -> H.ComponentHTML i () w
renderRoute = case _ of
  Home -> div [] [ text "🏠 Page d'accueil" ]
  About -> div [] [ text "ℹ️ À propos" ]
  NotFound -> div [] [ text "❌ Page non trouvée" ]
