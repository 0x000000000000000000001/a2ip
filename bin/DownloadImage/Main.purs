module Bin.DownloadImage.Main (main) where

import Prelude

import Data.Array (filter, length)
import Data.Either (Either(..), isLeft, isRight)
import Effect (Effect)
import Effect.Aff (Aff, try)
import Utils.Async (parTraverseBounded)
import Bin.Util.Log (logError, logInfo, logSuccess, runBinAff)
import Util.File.Image (downloadImage)
import Util.File.Path (imageDirPath)

type Image = 
  { url :: String
  , filename :: String
  }

imagesToDownload :: Array Image
imagesToDownload = 
  [ { url: "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/011_The_lion_king_Tryggve_in_the_Serengeti_National_Park_Photo_by_Giles_Laurent.jpg/1920px-011_The_lion_king_Tryggve_in_the_Serengeti_National_Park_Photo_by_Giles_Laurent.jpg", filename: "test1.png" }
  , { url: "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/011_The_lion_king_Tryggve_in_the_Serengeti_National_Park_Photo_by_Giles_Laurent.jpg/1920px-011_The_lion_king_Tryggve_in_the_Serengeti_National_Park_Photo_by_Giles_Laurent.jpg", filename: "test2.png" }
  , { url: "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/011_The_lion_king_Tryggve_in_the_Serengeti_National_Park_Photo_by_Giles_Laurent.jpg/1920px-011_The_lion_king_Tryggve_in_the_Serengeti_National_Park_Photo_by_Giles_Laurent.jpg", filename: "test3.png" }
  , { url: "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/011_The_lion_king_Tryggve_in_the_Serengeti_National_Park_Photo_by_Giles_Laurent.jpg/1920px-011_The_lion_king_Tryggve_in_the_Serengeti_National_Park_Photo_by_Giles_Laurent.jpg", filename: "test4.png" }
  , { url: "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/011_The_lion_king_Tryggve_in_the_Serengeti_National_Park_Photo_by_Giles_Laurent.jpg/1920px-011_The_lion_king_Tryggve_in_the_Serengeti_National_Park_Photo_by_Giles_Laurent.jpg", filename: "test5.png" }
  , { url: "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/011_The_lion_king_Tryggve_in_the_Serengeti_National_Park_Photo_by_Giles_Laurent.jpg/1920px-011_The_lion_king_Tryggve_in_the_Serengeti_National_Park_Photo_by_Giles_Laurent.jpg", filename: "test6.png" }
  , { url: "https://invalid-url.com/image.jpg", filename: "test7.jpg" }
  ]
  

main :: Effect Unit
main = runCLI do
  logInfo "Starting downloads..."
  results <- parTraverseBounded 3 downloadWithErrorHandling imagesToDownload

  let successes = filter isRight results
  let failures = filter isLeft results

  logSuccess $ "Successful downloads: " <> show (length successes)
  if length failures > 0 
    then logError $ "Failed downloads: " <> show (length failures)
    else pure unit

  where
  downloadWithErrorHandling :: Image -> Aff (Either String String)
  downloadWithErrorHandling { url, filename } = do
    logInfo $ "Downloading: " <> filename
    result <- try $ downloadImage url (imageDirPath <> filename)
    case result of
      Left error -> do
        logError $ "Failed " <> filename <> ": " <> show error
        pure $ Left filename
      Right _ -> do
        logSuccess $ "Success " <> filename
        pure $ Right filename
