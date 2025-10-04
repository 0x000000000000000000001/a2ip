module Bin.DownloadImage.Main (main) where

import Prelude

import Ansi.Codes (EscapeCode(..), EraseParam(..), escapeCodeToString)
import Bin.Util.Log (colorize, CliColor(..), log, runBinAff, write)
import Bin.Util.Log.Error (errorPrefixed)
import Bin.Util.Log.Success (successPrefixed)
import Data.Array (length)
import Data.Either (Either(..))
import Data.Foldable (for_)
import Effect (Effect)
import Effect.Aff (Aff)
import Effect.Aff.AVar as AVar
import Util.Async (parTraverseBounded)
import Util.File.Image (downloadImage)
import Util.File.Path (imageDirPath)

type Image = 
  { idx :: Int 
  , url :: String
  , filename :: String
  }

imagesToDownload :: Array Image
imagesToDownload = 
  [ { idx: 0, url: "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/011_The_lion_king_Tryggve_in_the_Serengeti_National_Park_Photo_by_Giles_Laurent.jpg/1920px-011_The_lion_king_Tryggve_in_the_Serengeti_National_Park_Photo_by_Giles_Laurent.jpg", filename: "test1.png" }
  , { idx: 1, url: "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/011_The_lion_king_Tryggve_in_the_Serengeti_National_Park_Photo_by_Giles_Laurent.jpg/1920px-011_The_lion_king_Tryggve_in_the_Serengeti_National_Park_Photo_by_Giles_Laurent.jpg", filename: "test2.png" }
  , { idx: 2, url: "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/011_The_lion_king_Tryggve_in_the_Serengeti_National_Park_Photo_by_Giles_Laurent.jpg/1920px-011_The_lion_king_Tryggve_in_the_Serengeti_National_Park_Photo_by_Giles_Laurent.jpg", filename: "test3.png" }
  , { idx: 3, url: "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/011_The_lion_king_Tryggve_in_the_Serengeti_National_Park_Photo_by_Giles_Laurent.jpg/1920px-011_The_lion_king_Tryggve_in_the_Serengeti_National_Park_Photo_by_Giles_Laurent.jpg", filename: "test4.png" }
  , { idx: 4, url: "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/011_The_lion_king_Tryggve_in_the_Serengeti_National_Park_Photo_by_Giles_Laurent.jpg/1920px-011_The_lion_king_Tryggve_in_the_Serengeti_National_Park_Photo_by_Giles_Laurent.jpg", filename: "test5.png" }
  , { idx: 5, url: "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/011_The_lion_king_Tryggve_in_the_Serengeti_National_Park_Photo_by_Giles_Laurent.jpg/1920px-011_The_lion_king_Tryggve_in_the_Serengeti_National_Park_Photo_by_Giles_Laurent.jpg", filename: "test6.png" }
  , { idx: 6, url: "https://invalid-url.com/image.jpg", filename: "test7.jpg" }
  ]

main :: Effect Unit
main = runBinAff do
  writeLock <- AVar.new unit
  
  for_ imagesToDownload \{ filename } -> do
    log $ colorize Grey "⏳ Pending" <> " " <> filename <> "..."

  let totalLines = length imagesToDownload
  
  void $ parTraverseBounded 3 (downloadWithErrorHandling writeLock totalLines) imagesToDownload
  
  write $ escapeCodeToString (Down totalLines) <> "\r" 

  where
  updateLine :: AVar.AVar Unit -> Int -> Int -> String -> Aff Unit
  updateLine lock totalLines lineIdx message = do
    token <- AVar.take lock
    
    let linesToGoUp = totalLines - lineIdx
    
    write $ escapeCodeToString (Up linesToGoUp)     
       <> "\r"                                       
       <> escapeCodeToString (EraseLine Entire)    
       <> message                                    
       <> escapeCodeToString (Down linesToGoUp)     
       <> "\r"                                       
    
    AVar.put token lock

  downloadWithErrorHandling :: AVar.AVar Unit -> Int -> Image -> Aff (Either String String)
  downloadWithErrorHandling lock totalLines { idx, url, filename } = do
    updateLine lock totalLines idx (colorize Blue "⬇️  Downloading" <> " " <> filename <> "...")

    result <- downloadImage url (imageDirPath <> filename)
    case result of
      Left e -> do
        updateLine lock totalLines idx (errorPrefixed "Failed " true true <> filename <> ": " <> e)
        pure $ Left filename
      Right _ -> do
        updateLine lock totalLines idx (successPrefixed "Downloaded " true true <> filename)
        pure $ Right filename
