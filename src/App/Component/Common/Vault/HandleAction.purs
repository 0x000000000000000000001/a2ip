module App.Component.Common.Vault.HandleAction
  ( handleAction
  ) where

import Proem

import App.Component.Common.Vault.Type (Action(..), Output(..), Phase(..), VaultM, _Locked)
import Data.Lens (_Just, (.~), (^?))
import Data.Maybe (Maybe(..))
import Data.Traversable (for_)
import Effect.Aff (Milliseconds(..), delay)
import Effect.Console (log)
import Effect.Ref (new, read, write)
import Halogen (fork, get, modify_)
import Halogen.Query.HalogenM (raise)
import Util.Proxy.Dictionary.PasswordInputValue (_passwordInputValue)
import Util.Proxy.Dictionary.Phase (_phase)
import App.Component.Common.Vault.Style.Front as Front

handleAction :: ∀ q i o. Action i o -> (VaultM q i o) Unit
handleAction = case _ of
  Initialize -> do
    ref <- ʌ $ new ""

    modify_ (_ # _phase ◁ _Locked ◁ _passwordInputValue .~ Just ref)

  Receive input -> 
    modify_ _ 
      { input = input
      , innerInput = input.innerInput
      }
  
  HandleSubmit -> do
    state <- get

    for_ (state ^? _phase ◁ _Locked ◁ _passwordInputValue ◁ _Just) \ref -> do
      currentPasswordInputValue <- ʌ $ read ref

      when (state.input.password /= currentPasswordInputValue) do 
        ʌ $ log "Incorrect password entered."

      when (state.input.password == currentPasswordInputValue) do 
        modify_ _ { phase = Unlocking }

        ø $ fork do 
          ʌ' $ delay $ Milliseconds $ Front.animationDurationMs + 200.0 -- +100 for a little bit of suspense...
          modify_ _ { phase = Unlocked }

  HandleNewPasswordInputValue newValue -> do 
    state <- get 

    for_ (state ^? _phase ◁ _Locked ◁ _passwordInputValue ◁ _Just) \ref ->
      ʌ $ write newValue ref

  RaiseInnerOutput output -> raise (InnerOutputRaised output)

  DoNothing -> ηι
    