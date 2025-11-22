module Ui.Component.Page.About.HandleAction
  ( handleAction
  , toPerson
  ) where

import Proem

import Halogen (fork)
import Ui.Component.Page.About.Type (AboutM, Action(..), Person, _collaborators, _members)
import Ui.Component.Util.Remote (fetchModify)
import Util.Google.Sheet (Converter)
import Util.Proxy.Dictionary.Collaborators (collaborators')
import Util.Proxy.Dictionary.Country (country')
import Util.Proxy.Dictionary.Email (email')
import Util.Proxy.Dictionary.Firstname (firstname')
import Util.Proxy.Dictionary.Job (job')
import Util.Proxy.Dictionary.Lastname (lastname')
import Util.Proxy.Dictionary.Members (members')
import Util.Proxy.Dictionary.Phone (phone')
import Util.Proxy.Dictionary.Role (role')

handleAction :: Action -> AboutM Unit
handleAction = case _ of
  Load -> do
    ø $ fork $ fetchModify members' _members toPerson identity
    ø $ fork $ fetchModify collaborators' _collaborators toPerson identity

    -- modify_ (_ # lens .~ Loading)
    -- data' <- fetch proxy to
    -- data'
    --   ?! (\m -> modify_ (_ # lens .~ (Success $ finalize m)))
    --   ⇿ (\e -> do
    --     error $ "Error fetching " <> ᴠ proxy <> ": " <> e
    --     modify_ (_ # lens .~ Failure e)
    --   )

toPerson :: Converter Person
toPerson get row =
  { firstname: get firstname' row
  , lastname: get lastname' row
  , role: get role' row
  , job: get job' row
  , phone: get phone' row
  , email: get email' row
  , country: get country' row
  }