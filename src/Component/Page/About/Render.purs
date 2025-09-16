module Component.Page.About.Render where

import Prelude hiding (div)

import Capability.Log (class Log)
import Capability.Navigate (class Navigate)
import Component.Page.About.Type (Action, State, Slots)
import Data.Maybe (Maybe(..))
import Data.Array (uncons)
import Effect.Aff.Class (class MonadAff)
import Halogen as H
import Halogen.HTML (div_, text, h1_, h2_, table_, thead_, tbody_, tr_, th_, td_)
import Halogen.HTML as HH

render :: forall m. MonadAff m => Navigate m => Log m => State -> H.ComponentHTML Action Slots m
render state =
  div_
    [ h1_ [ text "About Page" ] 
    , case state of
        { isLoading: true } -> 
          div_ [ text "Loading Google Sheets data..." ]
          
        { error: Just errorMsg } ->
          div_ 
            [ h2_ [ text "Error" ]
            , text $ "Failed to load data: " <> errorMsg
            ]
            
        { data: Just data_, isLoading: false } ->
          div_
            [ h2_ [ text data_.title ]
            , renderTable data_.rows
            ]
            
        _ ->
          div_ [ text "No data available" ]
    ]

renderTable :: forall w i. Array (Array String) -> HH.HTML w i
renderTable rows = 
  case uncons rows of
    Nothing -> text "No data to display"
    Just { head: headers, tail: dataRows } ->
      table_
        [ thead_ 
            [ tr_ (headers # map \header -> th_ [ text header ]) ]
        , tbody_
            (dataRows # map \row ->
              tr_ (row # map \cell -> td_ [ text cell ])
            )
        ]
