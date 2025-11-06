module App.Component.Common.Vault.HandleAction
  ( handleAction
  ) where

import Proem

import App.Component.Common.Vault.Style.Front as Front
import App.Component.Common.Vault.Type (Action(..), Output(..), Phase(..), VaultM, _Locked)
import Data.Lens (_Just, (.~), (^?))
import Data.Maybe (Maybe(..))
import Data.Traversable (for_)
import Effect.Aff (Milliseconds(..), delay)
import Effect.Ref (new, read, write)
import Halogen (fork, get, modify_)
import Halogen.Query.HalogenM (raise)
import Util.Proxy.Dictionary.Incorrect (_incorrect)
import Util.Proxy.Dictionary.PasswordInputValue (_passwordInputValue)
import Util.Proxy.Dictionary.Phase (_phase)

handleAction :: ∀ q i o. Action i o -> (VaultM q i o) Unit
handleAction = case _ of
  Initialize -> do
    ref <- ʌ $ new ""

    modify_ (_ # _phase ◁ _Locked ◁ _passwordInputValue .~ Just ref)

  Receive input -> modify_ _ { input = input }
  
  HandleSubmit -> do
    state <- get

    for_ (state ^? _phase ◁ _Locked ◁ _passwordInputValue ◁ _Just) \ref -> do
      currentPasswordInputValue <- ʌ $ read ref

      let isPasswordCorrect = state.input.password == currentPasswordInputValue

      when (not isPasswordCorrect) do
        modify_ (_ # _phase ◁ _Locked ◁ _incorrect .~ true)

      when (isPasswordCorrect) do
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
    