module Bin.Command.DownloadGoogleSheetImages.Main (main) where

import Prelude

import Ansi.Codes (EscapeCode(..), EraseParam(..), escapeCodeToString)
import Bin.Capability.BinM (BinM, runBinM)
import Bin.Util.Exit (exitSuccess)
import Bin.Util.Log.Download (downloadPrefixed)
import Bin.Util.Log.Error (error, errorPrefixed)
import Bin.Util.Log.Log (carriageReturn, log, write)
import Bin.Util.Log.Pending (pendingPrefixed)
import Bin.Util.Log.Success (successPrefixed, successShortAfterNewline)
import Component.Page.About.HandleAction (fetchMembers, ourImageAbsolutePath)
import Config.Config (config)
import Data.Array (catMaybes, filter, last, length, mapWithIndex)
import Data.Either (Either(..))
import Data.Maybe (Maybe(..), fromMaybe, maybe)
import Data.String (Pattern(..), split, trim)
import Data.Traversable (for_)
import Effect (Effect)
import Effect.Aff (Aff, attempt)
import Node.FS.Aff (stat)
import Util.File.Image (downloadImage)
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

  case members of 
    Left err -> do
      error $ "Error fetching table HTML: " <> err
      pure []
    Right members_ -> do
      pure $ catMaybes $ 
        mapWithIndex 
        (\idx member -> 
          maybe 
          Nothing
          (\{ portraitId, originalPortraitUrl, finalPortraitUrl } -> Just 
            { idx
            , id: portraitId
            , url: originalPortraitUrl
            , filename: trim $ fromMaybe "" $ last $ split (Pattern "/") finalPortraitUrl
            }
          ) 
          member
        ) 
        $ filter 
          (\member -> 
            case member of
              Nothing -> false
              Just { finalPortraitUrl } -> (trim $ finalPortraitUrl) /= ""
          )
          members_

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
  let filePath = ourImageAbsolutePath id
      updateLine' prefixedFn prefix suffix = updateLine lock totalLines idx (prefixedFn prefix true true <> filename <> suffix)
  
  fileExistsResult <- attempt $ stat filePath
  
  case fileExistsResult of
    Right _ -> do
      updateLine' successPrefixed "Already downloaded " ""
    Left _ -> do
      updateLine' downloadPrefixed "Downloading " "..."

      result <- downloadImage url filePath

      case result of
        Left e -> do
          updateLine' errorPrefixed "Failed " $ ": \"" <> e <> "\""
        Right _ -> do
          updateLine' successPrefixed "Downloaded " ""

  pure unit