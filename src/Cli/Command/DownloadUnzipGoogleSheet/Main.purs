module Cli.Command.DownloadUnzipGoogleSheet.Main (main) where

import Proem

import Affjax (printError)
import Affjax.ResponseFormat (arrayBuffer)
import Cli.Util.Capability.BinM (runBinM)
import Cli.Util.Log.Error (errorShowAfterNewline)
import Cli.Util.Log.Info (info, infoAfterNewline)
import Cli.Util.Log.Log (log)
import Cli.Util.Log.Success (successShortAfterNewline)
import Effect (Effect)
import Effect.Exception (message)
import Util.File.Path (rootDirAbsolutePath)
import Util.File.Unzip (unzipToDirectory)
import Util.Google.Sheet (googleSheetHtmlZipDownloadUrl)
import Util.Http.Http (get)

main :: Effect Unit
main = runBinM false do
  infoAfterNewline "Downloading..."

  result <- ʌ' $ get arrayBuffer googleSheetHtmlZipDownloadUrl
  result
    ?!
      ( \response -> do
          info "Unzipping..."
      
          res <- ʌ' $ unzipToDirectory (rootDirAbsolutePath <> "asset/sheet/") response.body
          res 
            ?! (κ $ successShortAfterNewline "Unzipped successfully.")
            ⇿ (\err -> errorShowAfterNewline $ "Error unzipping: " <> message err)
      )
    ⇿ \e -> log $ "Failed to fetch ZIP: " <> printError e
