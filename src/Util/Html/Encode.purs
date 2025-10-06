module Util.Html.Encode
  ( decodeHtmlEntities
  , encodeHtmlEntities
  ) where

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
foreign import decodeHtmlEntities :: String -> String

-- | Encode HTML entities.
-- | 
-- | Examples:
-- | ```purescript
-- | >>> encodeHtmlEntities "<div>Hello & world</div>"
-- | "&lt;div&gt;Hello &amp; world&lt;/div&gt;"
-- | ```
foreign import encodeHtmlEntities :: String -> String
