module Cli.Command.DownloadGoogleSheetImages.Main (main) where

import Proem

import Ansi.Codes (EscapeCode(..), EraseParam(..), escapeCodeToString)
import Ui.Component.Page.About.HandleAction (toPerson)
import Ui.Component.Page.Util.Image (ourImageRelativePath)
import Cli.Util.Capability.BinM (BinM, runBinM)
import Cli.Util.Log.Download (downloadPrefixed)
import Cli.Util.Log.Error (error, errorPrefixed)
import Cli.Util.Log.Log (carriageReturn, log, write)
import Cli.Util.Log.Pending (pendingPrefixed)
import Cli.Util.Log.Success (successPrefixed, successShortAfterNewline)
import Data.Array (filter, length)
import Data.String (trim)
import Data.Traversable (for_)
import Data.TraversableWithIndex (forWithIndex)
import Effect (Effect)
import Effect.Aff (Aff, attempt)
import Node.FS.Aff (stat)
import Util.File.Image.Common (googleDriveImageUrl, suffixWithExt)
import Util.File.Image.Node (downloadImage)
import Util.File.Path (rootDirPath)
import Util.Google.Sheet (fetch)
import Util.Proxy.Dictionary.Members (members')
import Util.Semaphor (Sem, lock, lockAcq, lockRel, parTraverseBounded)

main :: Effect Unit
main = runBinM false do
  writeLock <- lock

  images <- imagesToDownload 

  for_ images \{ filename } -> do
    log $ pendingPrefixed "Pending " true true <> " " <> filename <> "..."

  let totalLines = length images
  
  ø $ parTraverseBounded 3 (download writeLock totalLines) images
  
  write $ escapeCodeToString (Down totalLines) <> carriageReturn

  successShortAfterNewline "Done!"

type Image =
  { idx :: Int
  , id :: String
  , url :: String
  , filename :: String
  }

imagesToDownload :: BinM (Array Image)
imagesToDownload = do 
  members <- fetch members' toPerson

  members 
    ?! (\members_ -> do
      let validMembers = filter (\{ portraitId } -> trim portraitId /= "") members_
      
      imgs <-
        forWithIndex 
          validMembers
          \idx { portraitId } -> do
            url <- googleDriveImageUrl portraitId
            η { idx
              , id: portraitId
              , url
              , filename: suffixWithExt portraitId
              }
      
      η imgs
    ) ⇿ (\err -> do
      error $ "Error fetching table HTML: " <> err
      η []
    )

updateLine :: Sem -> Int -> Int -> String -> Aff Unit
updateLine lock totalLines lineIdx message = do
  lockAcq lock
  
  let linesToGoUp = totalLines - lineIdx

  write $ escapeCodeToString (Up linesToGoUp)
    <> carriageReturn
    <> escapeCodeToString (EraseLine Entire)
    <> message
    <> escapeCodeToString (Down linesToGoUp)
    <> carriageReturn

  lockRel lock

download :: Sem -> Int -> Image -> Aff Unit
download lock totalLines { idx, id, url, filename } = do
  let filePath = rootDirPath <> ourImageRelativePath id
      updateLine' prefixedFn prefix suffix = updateLine lock totalLines idx (prefixedFn prefix true true <> filename <> suffix)
  
  fileExistsResult <- attempt $ stat filePath
  
  fileExistsResult
    ?! (κ do
      updateLine' successPrefixed "Already downloaded " ""
    ) ⇿ (κ do
      updateLine' downloadPrefixed "Downloading " "..."

      result <- downloadImage url filePath

      result
        ?! (κ $ updateLine' successPrefixed "Downloaded " "")
        ⇿ (\e -> updateLine' errorPrefixed "Failed " $ ": \"" <> e <> "\"")
    )