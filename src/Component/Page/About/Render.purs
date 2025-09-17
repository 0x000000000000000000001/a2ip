module Component.Page.About.Render where

import Prelude hiding (div)

import Capability.Log (class Log)
import Capability.Navigate (class Navigate)
import Component.Page.About.Type (Action, State, Slots, Member)
import Data.Maybe (Maybe(..))
import Effect.Aff.Class (class MonadAff)
import Halogen as H
import Halogen.HTML (div_, text, p_, h3_)
import Halogen.HTML as HH

render :: forall m. MonadAff m => Navigate m => Log m => State -> H.ComponentHTML Action Slots m
render state =
  case state.data of
    Nothing -> 
      if state.isLoading 
        then text "Loading..."
        else text ""
    
    Just members -> 
      div_ (map renderMemberCard members)

renderMemberCard :: forall w i. Member -> HH.HTML w i
renderMemberCard member =
  div_
    [ h3_ [ text $ member.firstname <> " " <> member.lastname ]
    , p_ [ text $ "Role: " <> member.role ]
    , p_ [ text $ "Job: " <> member.job ]
    , p_ [ text $ "Phone: " <> member.phone ]
    , p_ [ text $ "Email: " <> member.email ]
    ]
