module Bin.Command.DownloadGoogleSheetImages.Main (main) where

import Prelude

import Ansi.Codes (EscapeCode(..), EraseParam(..), escapeCodeToString)
import Bin.Capability.BinM (BinM, runBinM)
import Bin.Util.Log.Download (downloadPrefixed)
import Bin.Util.Log.Error (error, errorPrefixed)
import Bin.Util.Log.Log (carriageReturn, log, write)
import Bin.Util.Log.Pending (pendingPrefixed)
import Bin.Util.Log.Success (successPrefixed, successShortAfterNewline)
import Component.Page.About.HandleAction (fetchMembers)
import Config.Config (config)
import Data.Array (catMaybes, length, mapWithIndex)
import Data.Either (Either(..))
import Data.Maybe (Maybe(..), maybe)
import Data.Traversable (for_)
import Effect (Effect)
import Effect.Aff (Aff)
import Effect.Class (liftEffect)
import Node.Process (exit')
import Util.File.Image (downloadImage)
import Util.File.Path (imageDirPath)
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

  liftEffect $ exit' 0

type Image =
  { idx :: Int
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
          (\{ portraitId, portraitUrl } -> Just 
            { idx
            , url: portraitUrl 
            , filename: portraitId <> ".png"
            }
          ) 
          member
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

download :: Sem -> Int -> Image -> Aff (Either String String)
download lock totalLines { idx, url, filename } = do
  updateLine lock totalLines idx (downloadPrefixed "⬇️  Downloading " true true <> filename <> "...")

  result <- downloadImage url (imageDirPath <> "component/page/about/member/" <> filename)

  case result of
    Left e -> do
      updateLine lock totalLines idx (errorPrefixed "Failed " true true <> filename <> ": \"" <> e <> "\"")
      pure $ Left filename
    Right _ -> do
      updateLine lock totalLines idx (successPrefixed "Downloaded " true true <> filename)
      pure $ Right filename