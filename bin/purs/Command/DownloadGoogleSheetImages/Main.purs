module Bin.Command.DownloadGoogleSheetImages.Main (main) where

import Proem

import Ansi.Codes (EscapeCode(..), EraseParam(..), escapeCodeToString)
import Bin.Capability.BinM (BinM, runBinM)
import Bin.Util.Exit (exitSuccess)
import Bin.Util.Log.Download (downloadPrefixed)
import Bin.Util.Log.Error (error, errorPrefixed)
import Bin.Util.Log.Log (carriageReturn, log, write)
import Bin.Util.Log.Pending (pendingPrefixed)
import Bin.Util.Log.Success (successPrefixed, successShortAfterNewline)
import Component.Page.About.HandleAction (fetchMembers, googleDriveImageUrl, ourImageRelativePath, suffixPortraitIdWithExt)
import Config.Config (config)
import Data.Array (catMaybes, filter, length, mapWithIndex)
import Data.Maybe (Maybe(..))
import Data.String (trim)
import Data.Traversable (for_)
import Effect (Effect)
import Effect.Aff (Aff, attempt)
import Node.FS.Aff (stat)
import Util.File.Image (downloadImage)
import Util.File.Path (rootDirPath)
import Util.Semaphor (Sem, lock, lockAcq, lockRel, parTraverseBounded)

main :: Effect Unit
main = runBinM config do
  writeLock <- lock

  images <- imagesToDownload 

  for_ images \{ filename } -> do
    log $ pendingPrefixed "Pending " true true <> " " <> filename <> "..."

  let totalLines = length images
  
  void $ parTraverseBounded 3 (download writeLock totalLines) images
  
  write $ escapeCodeToString (Down totalLines) <> carriageReturn

  successShortAfterNewline "Done!"

  exitSuccess

type Image =
  { idx :: Int
  , id :: String
  , url :: String
  , filename :: String
  }

imagesToDownload :: BinM (Array Image)
imagesToDownload = do 
  members <- fetchMembers 

  members 
    ?! (\members_ -> do 
      pure $ catMaybes $ 
        mapWithIndex 
        (\idx member -> member >>= (\{ portraitId } -> Just 
          { idx
          , id: portraitId
          , url: googleDriveImageUrl portraitId
          , filename: suffixPortraitIdWithExt portraitId
          })
        )
        $ filter 
          (\member -> member ?? (\{ portraitId } -> (trim portraitId) /= "") ⇔ false)
          members_
    ) ⇿ (\err -> do
      error $ "Error fetching table HTML: " <> err
      pure []
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
    ?! (const $ do
      updateLine' successPrefixed "Already downloaded " ""
    ) ⇿ (const $ do
      updateLine' downloadPrefixed "Downloading " "..."

      result <- downloadImage url filePath

      result
        ?! (const $ updateLine' successPrefixed "Downloaded " "")
        ⇿ (\e -> updateLine' errorPrefixed "Failed " $ ": \"" <> e <> "\"")
    )

  pure unit