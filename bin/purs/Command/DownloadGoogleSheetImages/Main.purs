module Bin.Command.DownloadGoogleSheetImages.Main (main) where

import Prelude

import Ansi.Codes (EscapeCode(..), EraseParam(..), escapeCodeToString)
import Bin.Capability.BinM (runBinM)
import Bin.Util.Log.Download (downloadPrefixed)
import Bin.Util.Log.Error (error, errorPrefixed)
import Bin.Util.Log.Log (carriageReturn, log, write)
import Bin.Util.Log.Pending (pendingPrefixed)
import Bin.Util.Log.Success (successPrefixed)
import Component.Page.About.HandleAction (extractMappingKeysAndValuesFromTableHtml, fetchMembersTableHtml)
import Component.Page.About.Type (portraitId)
import Config.Config (config)
import Data.Array (last, length, (!!))
import Data.Either (Either(..))
import Data.FoldableWithIndex (forWithIndex_)
import Data.Generic.Rep (from)
import Data.Map (lookup)
import Data.Maybe (fromMaybe, maybe)
import Data.String (Pattern(..), split)
import Data.Traversable (for_)
import Effect (Effect)
import Effect.Aff (Aff)
import Effect.Class (liftEffect)
import Util.Async (Sem, lock, lockAcq, lockRel, parTraverseBounded)
import Util.File.Image (downloadImage)
import Util.File.Path (imageDirPath)
import Web.HTML.HTMLHyperlinkElementUtils (port)

type Image = 
  { url :: String
  , filename :: String
  }

imagesToDownload :: Aff (Array Image)
imagesToDownload = do 
  tableHtml <- fetchMembersTableHtml 
  case tableHtml of
    Left err -> do
      error $ "Error fetching table HTML: " <> err
      pure []
    Right tableHtml -> do
      let extractedData = extractMappingKeysAndValuesFromTableHtml tableHtml
          portraitIndex = lookup portraitId extractedData.keyIndices
          imageUrls :: Array String
          imageUrls = 
            maybe 
            [] 
            (\idx -> 
              fromMaybe 
              [] 
              $ extractedData.values # (_ !! idx)
            ) 
            portraitIndex
      pure $ imageUrls <#> \url -> { url, filename: fromMaybe "" $ last $ split (Pattern "/") url }

main :: Effect Unit
main = runBinM config do
  writeLock <- lock

  images <- imagesToDownload

  forWithIndex_ images \i { filename } -> do
    log $ pendingPrefixed "Pending " true true <> " " <> filename <> "..."

  let totalLines = length images
  
  void $ parTraverseBounded 3 (download writeLock totalLines) images
  
  write $ escapeCodeToString (Down totalLines) <> carriageReturn

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

download :: Sem -> Int -> Image -> Aff (Either String String)
download lock totalLines { idx, url, filename } = do
  updateLine lock totalLines idx (downloadPrefixed "⬇️  Downloading " true true <> filename <> "...")

  result <- downloadImage url (imageDirPath <> filename)

  case result of
    Left e -> do
      updateLine lock totalLines idx (errorPrefixed "Failed " true true <> filename <> ": \"" <> e <> "\"")
      pure $ Left filename
    Right _ -> do
      updateLine lock totalLines idx (successPrefixed "Downloaded " true true <> filename)
      pure $ Right filename