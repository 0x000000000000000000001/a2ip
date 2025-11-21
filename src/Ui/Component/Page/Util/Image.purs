module App.Component.Page.Util.Image
  ( ourImageRelativePath
  )
  where


import Util.File.Image.Common (ourImageRelativePath) as Base

ourImageRelativePath :: String -> String
ourImageRelativePath id = Base.ourImageRelativePath "component/page" id