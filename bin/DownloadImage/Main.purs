module Bin.DownloadImage.Main (main) where

import Prelude

import Ansi.Codes (Color(..))
import Bin.Util.Log (colorize, debug, debugShort, errorShort, infoShort, runBinAff, successShort, successShortAfterNewline, warn, warnShort)
import Data.Array (filter, length)
import Data.Either (Either(..), isLeft, isRight)
import Effect (Effect)
import Effect.Aff (Aff)
import Util.Async (parTraverseBounded)
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
main = runBinAff do
  results <- parTraverseBounded 3 downloadWithErrorHandling imagesToDownload

  let successes = filter isRight results
  let failures = filter isLeft results

  successShortAfterNewline $ (colorize Green "Passed") " downloads: " <> show (length successes)
  if length failures > 0 
    then errorShort $ "Failed downloads: " <> show (length failures)
    else pure unit

  where
  downloadWithErrorHandling :: Image -> Aff (Either String String)
  downloadWithErrorHandling { url, filename } = do
    infoShort $ "Downloading " <> filename <> "..."
    result <- downloadImage url (imageDirPath <> filename)
    case result of
      Left e -> do
        errorShort $ "Failed " <> filename <> ": " <> show e
        pure $ Left filename
      Right _ -> do 
        successShort $ "Downloaded " <> filename
        pure $ Right filename
