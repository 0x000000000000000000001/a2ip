module Bin.DownloadImage.Main (main) where

import Prelude

import Data.Array (filter, length)
import Data.Either (Either(..), isLeft, isRight)
import Effect (Effect)
import Effect.Aff (Aff, launchAff, launchAff_, try)
import Effect.Class (liftEffect)
import Effect.Console (log)
import Utils.Async (parTraverseBounded)
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
  launchAff $ do 
    liftEffect $ log "Starting downloads..."
    results <- parTraverseBounded 3 downloadWithErrorHandling imagesToDownload
    
    let successes = filter isRight results
    let failures = filter isLeft results
    
    liftEffect $ log $ "✅ Successful downloads: " <> show (length successes)
    liftEffect $ log $ "❌ Failed downloads: " <> show (length failures)
  where
    downloadWithErrorHandling :: Image -> Aff (Either String String)
    downloadWithErrorHandling { url, filename } = do
      liftEffect $ log $ "Downloading: " <> filename
      result <- try $ downloadImage url (imageDirPath <> filename)
      case result of 
        Left error -> do
          liftEffect $ log $ "❌ Failed " <> filename <> ": " <> show error
          pure $ Left filename
        Right _ -> do
          liftEffect $ log $ "✅ Success " <> filename
          pure $ Right filename
    