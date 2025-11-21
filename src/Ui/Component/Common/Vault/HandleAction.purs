module Ui.Component.Common.Vault.HandleAction
  ( handleAction
  ) where

import Proem

import Ui.Component.Common.Vault.Style.Front as Front
import Ui.Component.Common.Vault.Type (Action(..), Output(..), Phase(..), VaultM, _Locked)
import Data.Lens (_Just, (.~), (^?))
import Data.Maybe (Maybe(..), isJust)
import Data.Time.Duration (Seconds(..))
import Data.Traversable (for_)
import Effect.Aff (Milliseconds(..), delay)
import Effect.Ref (new, read, write)
import Halogen (fork, get, modify_)
import Halogen.Query.HalogenM (raise)
import Util.LocalStorage (getInLocalStorage, setInLocalStorage)
import Util.Module (reflectModuleName)
import Util.Proxy.Dictionary.Incorrect (_incorrect)
import Util.Proxy.Dictionary.PasswordInputValue (_passwordInputValue)
import Util.Proxy.Dictionary.Phase (_phase)

handleAction :: ∀ q i o. Action i o -> (VaultM q i o) Unit
handleAction = case _ of
  Initialize -> do
    ref <- ʌ $ new ""

    modify_ (_ # _phase ◁ _Locked ◁ _passwordInputValue .~ Just ref)

    state <- get

    let memoId = state.input.memoId

    alreadyUnlocked <- detectTraceOfSuccessfulUnlock memoId

    when alreadyUnlocked do
      modify_ _ { phase = Unlocked }

  Receive input -> modify_ _ { input = input }
  
  HandleSubmit -> do
    state <- get

    for_ (state ^? _phase ◁ _Locked ◁ _passwordInputValue ◁ _Just) \ref -> do
      currentPasswordInputValue <- ʌ $ read ref

      let isPasswordCorrect = state.input.password == currentPasswordInputValue

      when (not isPasswordCorrect) do
        modify_ (_ # _phase ◁ _Locked ◁ _incorrect .~ true)

      when (isPasswordCorrect) do
        leaveTraceOfSuccessfulUnlock state.input.memoId

        modify_ _ { phase = Unlocking }

        ø $ fork do 
          ʌ' $ delay $ Milliseconds $ Front.animationDurationMs + 200.0 -- +100 for a little bit of suspense...
          modify_ _ { phase = Unlocked }

  HandleNewPasswordInputValue newValue -> do 
    state <- get 

    for_ (state ^? _phase ◁ _Locked ◁ _passwordInputValue ◁ _Just) \ref ->
      ʌ $ write newValue ref

    modify_ (_ # _phase ◁ _Locked ◁ _incorrect .~ false)

  RaiseInnerOutput output -> raise (InnerOutputRaised output)

  DoNothing -> ηι

successfulUnlockTraceKey :: String -> String
successfulUnlockTraceKey id = reflectModuleName <> ":unlocked:" <> id

leaveTraceOfSuccessfulUnlock :: ∀ q i o. String -> VaultM q i o Unit
leaveTraceOfSuccessfulUnlock id = do
  setInLocalStorage 
    (successfulUnlockTraceKey id) 
    true 
    (Just $ Seconds 3600.0) -- 1 hour

detectTraceOfSuccessfulUnlock :: ∀ q i o. String -> VaultM q i o Boolean
detectTraceOfSuccessfulUnlock id = do
  maybeTrace <- (getInLocalStorage $ successfulUnlockTraceKey id) :: VaultM q i o (Maybe Boolean)
  η $ isJust maybeTrace

    