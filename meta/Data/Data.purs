module Meta.Data.Data
  ( Data
  , data'
  )
  where

foreign import _data :: 
  { env :: String
  }

type Data = 
  { env :: String
  }

data' :: Data
data' = 
  { env: _data.env
  }
