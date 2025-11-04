module App.Component.Util.Remote
  ( fetchModify
  )
  where

import App.Component.Util.Type (Remote)
import App.Util.Capability.AppM (AppM)
import App.Util.Capability.Log (error)
import Data.Lens (Lens', (.~))
import Data.Symbol (class IsSymbol)
import Halogen (HalogenM, modify_)
import Network.RemoteData (RemoteData(..))
import Proem (Unit, bind, discard, ᴠ, (#), ($), (<>), (?!), (⇿))
import Type.Prelude (Proxy)
import Util.Google.Sheet (Converter)
import Util.Google.Sheet as Sheet

fetchModify
  :: forall sym state action slots output a b
   . IsSymbol sym 
  => Proxy sym 
  -> Lens' state (Remote b)
  -> Converter a
  -> (Array a -> b)
  -> HalogenM state action slots output AppM Unit
fetchModify proxy lens to finalize = do
  modify_ (_ # lens .~ Loading)

  data' <- Sheet.fetch proxy to
  
  data'
    ?! (\m -> modify_ (_ # lens .~ (Success $ finalize m)))
    ⇿ (\e -> do
      error $ "Error fetching " <> ᴠ proxy <> ": " <> e
      modify_ (_ # lens .~ Failure e)
    )