module Cli.Command.Sync.Main
  ( main
  , sync
  )
  where

import Proem

import Affjax (printError)
import Affjax.ResponseFormat (arrayBuffer)
import Cli.Util.Capability.BinM (runBinM)
import Cli.Util.Log.Error (error)
import Cli.Util.Log.Info (info)
import Cli.Util.Log.Success (success)
import Effect (Effect)
import Effect.Aff.Class (class MonadAff)
import Effect.Exception (message)
import Util.File.Path (rootDirAbsolutePath)
import Util.File.Unzip (unzipToDirectory)
import Util.Google.Sheet (googleSheetHtmlZipDownloadUrl)
import Util.Http.Http (get)

main :: Effect Unit
main = runBinM false (sync info error success)

sync :: ∀ m. MonadAff m => (String -> m Unit) -> (String -> m Unit) -> (String -> m Unit) -> m Unit
sync log err sux = do
  log "Downloading..."

  result <- ʌ' $ get arrayBuffer googleSheetHtmlZipDownloadUrl
  result
    ?!
      ( \response -> do
          log "Unzipping..."
      
          res <- ʌ' $ unzipToDirectory (rootDirAbsolutePath <> "asset/sheet/") response.body
          res 
            ?! (κ $ sux "Unzipped successfully.")
            ⇿ (\err_ -> err $ "Error unzipping: " <> message err_)
      )
    ⇿ \e -> err $ "Failed to fetch ZIP: " <> printError e
