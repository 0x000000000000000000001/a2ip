module Bin.DownloadImage.Main (main) where

import Prelude

import Data.Array (filter, length)
import Data.Either (Either(..), either)
import Data.Traversable (traverse)
import Effect (Effect)
import Effect.Aff (Aff, launchAff_, try)
import Effect.Class (liftEffect)
import Effect.Console (log)
import Utils.File.Image (downloadImage)
import Utils.File.Path (imageDirPath)

type Image = 
  { url :: String
  , filename :: String
  }

imagesToDownload :: Array Image
imagesToDownload = 
  [ { url: "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/011_The_lion_king_Tryggve_in_the_Serengeti_National_Park_Photo_by_Giles_Laurent.jpg/1920px-011_The_lion_king_Tryggve_in_the_Serengeti_National_Park_Photo_by_Giles_Laurent.jpg", filename: "test1.png" }
  , { url: "https://invalid-url.com/image.jpg", filename: "test2.jpg" }
  ]

main :: Effect Unit
main = do 
  launchAff_ $ do 
    log "Starting downloads with error handling..."
    results <- traverse downloadWithErrorHandling imagesToDownload
    
    let successes = filter isSuccess results
    let failures = filter isFailure results
    
    log $ "✅ Successful downloads: " <> show (length successes)
    log $ "❌ Failed downloads: " <> show (length failures)
  where
    downloadWithErrorHandling :: Image -> Aff (Either String String)
    downloadWithErrorHandling { url, filename } = do
      log $ "Downloading: " <> filename
      result <- try $ downloadImage url (imageDirPath <> filename)
      case result of 
        Left error -> do
          liftEffect $ log $ "❌ Failed " <> filename <> ": " <> show error
          pure $ Left filename
        Right _ -> do
          liftEffect $ log $ "✅ Success " <> filename
          pure $ Right filename
    
    isSuccess = case _ of
      Right _ -> true
      Left _ -> false
    
    isFailure = not <<< isSuccess
 