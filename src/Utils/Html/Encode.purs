module Utils.Html.Encode
  ( decodeHtmlEntities
  , encodeHtmlEntities
  ) where

foreign import _decodeHtmlEntities :: String -> String

foreign import _encodeHtmlEntities :: String -> String

-- | Decode HTML entities.
-- | 
-- | Examples:
-- | ```purescript
-- | >>> decodeHtmlEntities "&lt;div&gt;Hello &amp; world&lt;/div&gt;"
-- | "<div>Hello & world</div>"
-- | 
-- | >>> decodeHtmlEntities "&quot;Hello&quot; &amp; &#39;World&#39;"  
-- | "\"Hello\" & 'World'"
-- | ```
decodeHtmlEntities :: String -> String
decodeHtmlEntities = _decodeHtmlEntities

-- | Encode HTML entities.
-- | 
-- | Examples:
-- | ```purescript
-- | >>> encodeHtmlEntities "<div>Hello & world</div>"
-- | "&lt;div&gt;Hello &amp; world&lt;/div&gt;"
-- | ```
encodeHtmlEntities :: String -> String
encodeHtmlEntities = _encodeHtmlEntities