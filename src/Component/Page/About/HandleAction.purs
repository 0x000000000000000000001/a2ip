module Component.Page.About.HandleAction where

import Prelude

import Affjax as AX
import Affjax.ResponseFormat (string)
import Affjax.Web (get)
import Capability.Log (class Log, log, Level(..))
import Component.Page.About.Type (Action(..), State, Member)
import Data.Either (Either(..))
import Data.Maybe (Maybe(..))
import Data.Array (index, drop, uncons) as Array
import Data.String (Pattern(..), split, trim, take, drop)
import Effect.Aff.Class (class MonadAff)
import Effect.Exception (Error, error)
import Halogen as H

googleSheetCsvLink :: String
googleSheetCsvLink = "https://docs.google.com/spreadsheets/d/1k5wU7ARnjasX6y29AEDcpW06Zk_13I2XI6kwgKlsVhE/export?format=csv"

handleAction :: forall o m. MonadAff m => Log m => Action -> H.HalogenM State Action () o m Unit
handleAction = case _ of
  LoadData -> do
    result <- H.liftAff $ fetchData

    case result of
      Left err -> log Error $ "Failed to load sheet data: " <> show err
      Right data_ -> H.modify_ _ { isLoading = false, data = Just data_ }

fetchData :: forall m. MonadAff m => m (Either Error (Array Member) )
fetchData = H.liftAff do
  result <- get string googleSheetCsvLink
  
  case result of
    Left err -> pure $ Left $ error $ "HTTP error: " <> AX.printError err
    Right response -> pure $ Right $ parseCsv response.body 

parseCsv :: String -> Array Member
parseCsv csvText = 
  let 
    lines = split (Pattern "\n") $ trim csvText
    -- Ligne 1: Headers pour humains (Nom, Prénom, etc.)
    -- Ligne 2: Keys pour mapping (lastname, firstname, etc.)
    -- Ligne 3+: Données
    mappingLine = case Array.index lines 1 of
      Just line -> parseCsvLine line
      Nothing -> [] -- Fallback si pas de ligne de mapping
    dataLines = Array.drop 2 lines -- Skip header et mapping lines
  in 
    map (parseCsvRowWithMapping mappingLine) dataLines

-- Parse une ligne CSV vers un Member en utilisant le mapping dynamique
parseCsvRowWithMapping :: Array String -> String -> Member
parseCsvRowWithMapping mappingKeys row = 
  let cols = parseCsvLine row
      getValue key = getColByKey key mappingKeys cols
  in { lastname: getValue "lastname"
     , firstname: getValue "firstname"  
     , role: getValue "role"
     , job: getValue "job"
     , email: getValue "email"
     , phone: getValue "phone"
     }

-- Récupère une valeur par clé en utilisant le mapping
getColByKey :: String -> Array String -> Array String -> String
getColByKey key mappingKeys dataColumns = 
  case findIndex key mappingKeys of
    Just index -> getCol index dataColumns
    Nothing -> "" -- Si la clé n'est pas trouvée

-- Trouve l'index d'une clé dans le mapping
findIndex :: String -> Array String -> Maybe Int
findIndex key arr = findIndexHelper key arr 0

findIndexHelper :: String -> Array String -> Int -> Maybe Int
findIndexHelper _ [] _ = Nothing
findIndexHelper key arr currentIndex = 
  case Array.index arr currentIndex of
    Nothing -> Nothing
    Just value -> 
      if trim value == key 
        then Just currentIndex
        else findIndexHelper key arr (currentIndex + 1)

-- Récupère une colonne par index avec fallback
getCol :: Int -> Array String -> String
getCol pos arr = case Array.index arr pos of
  Just value -> trim value
  Nothing -> ""

-- Parse simple CSV avec gestion basique des guillemets
parseCsvLine :: String -> Array String
parseCsvLine line = 
  let cleanLine = replaceQuotedCommas line
      fields = map trim $ split (Pattern ",") cleanLine
  in map restoreCommasAndCleanQuotes fields

-- Remplace les virgules à l'intérieur des guillemets par un placeholder
replaceQuotedCommas :: String -> String
replaceQuotedCommas str = processQuotes str false ""

temporaryCommaPlaceholder :: String
temporaryCommaPlaceholder = "__temporary_comma__"

-- Traite les guillemets caractère par caractère
processQuotes :: String -> Boolean -> String -> String
processQuotes "" _ acc = acc
processQuotes str inQuotes acc =
  let firstChar = take 1 str
      rest = drop 1 str
  in case firstChar of
    "\"" -> processQuotes rest (not inQuotes) (acc <> "\"")
    "," -> 
      if inQuotes 
        then processQuotes rest inQuotes (acc <> temporaryCommaPlaceholder)
        else processQuotes rest inQuotes (acc <> ",")
    char -> processQuotes rest inQuotes (acc <> char)

-- Restore commas and remove quotes
restoreCommasAndCleanQuotes :: String -> String
restoreCommasAndCleanQuotes str = 
  let withCommas = replaceString (Pattern temporaryCommaPlaceholder) "," str
      withoutQuotes = replaceString (Pattern "\"") "" withCommas
  in withoutQuotes

-- Remplace un pattern par un string de remplacement
replaceString :: Pattern -> String -> String -> String
replaceString pattern replacement input = 
  let parts = split pattern input
  in joinWith replacement parts

-- Joint un array de strings avec un séparateur
joinWith :: String -> Array String -> String
joinWith _ [] = ""
joinWith _ [x] = x
joinWith sep arr = case Array.uncons arr of
  Nothing -> ""
  Just { head: x, tail: xs } -> x <> sep <> joinWith sep xs
