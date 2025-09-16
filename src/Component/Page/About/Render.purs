module Component.Page.About.Render where

import Prelude hiding (div)

import Capability.Log (class Log)
import Capability.Navigate (class Navigate)
import Component.Page.About.Type (Action(..), State, Slots)
import Data.Maybe (Maybe(..))
import Data.Array (length)
import Effect.Aff.Class (class MonadAff)
import Halogen as H
import Halogen.HTML (div_, text, h1_, h2_, p_, pre_, button)
import Halogen.HTML.Events (onClick)
import Halogen.HTML.Properties (disabled)

render :: forall m. MonadAff m => Navigate m => Log m => State -> H.ComponentHTML Action Slots m
render state =
  div_
    [ h1_ [ text "📊 À propos - Google Sheets Data" ]
    , p_ [ text "Cette page charge des données depuis une feuille Google Sheets publique." ]
    
    , -- Bouton de chargement
      button 
        [ disabled state.isLoading
        , onClick $ const LoadSheetData
        ]
        [ text $ if state.isLoading then "⏳ Chargement..." else "🔄 Recharger les données" ]
    
    , -- Affichage des erreurs
      case state.error of
        Just errorMsg -> 
          div_
            [ h2_ [ text "❌ Erreur" ]
            , text $ "Erreur: " <> errorMsg
            ]
        Nothing -> text ""
    
    , -- Affichage des données en JSON brut
      case state.data of
        Nothing -> 
          if state.isLoading 
            then div_ [ text "⏳ Chargement des données en cours..." ]
            else div_ [ text "💡 Cliquez sur le bouton pour charger les données." ]
        
        Just csvData -> 
          div_
            [ h2_ [ text $ "✅ " <> csvData.title ]
            , p_ [ text $ "Nombre de lignes: " <> show (length csvData.rows) ]
            , h2_ [ text "📄 Données JSON brutes:" ]
            , pre_ [ text $ show csvData ]
            ]
    ]
