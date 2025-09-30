module Bin.DownloadImage.Main (main) where

import Prelude

import Effect (Effect)
import Effect.Aff (launchAff_)
import Utils.File.Image (downloadImage)
import Utils.File.Path (rootDirPath)

main :: Effect Unit
main = do
  launchAff_ $ do 
    downloadImage 
      "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/011_The_lion_king_Tryggve_in_the_Serengeti_National_Park_Photo_by_Giles_Laurent.jpg/1920px-011_The_lion_king_Tryggve_in_the_Serengeti_National_Park_Photo_by_Giles_Laurent.jpg" 
      $ rootDirPath <> "asset/image/test.jpg"
 