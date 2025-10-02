module Test.Component.Page.About.HandleAction.ConvertExtractedDataToMembers where

import Prelude

-- import Component.Page.About.HandleAction (convertExtractedDataToMembers)
-- import Component.Page.About.Type (email, firstname, job, lastname, phone, portraitId, role)
-- import Data.Map (fromFoldable)
-- import Data.Tuple (Tuple(..))
import Test.Spec (Spec)
-- import Test.Util.Assert ((===))
-- import Util.Array.Map (arrayToIndexMap)
import Test.Util.Describe (describe)

spec :: Spec Unit
spec = describe do

  pure unit

  -- it "converts complete data with all fields" do
  --   let keys = [firstname, lastname, role, job, phone, email, portraitId]
  --   let keyIndices = arrayToIndexMap keys
  --   let values = [["John", "Doe", "Developer", "Software Engineer", "123-456-7890", "john@example.com", "portrait123"]]
  --   let extractedData = { keys, keyIndices, values }
  --   let expected = [
  --     { firstname: "John"
  --     , lastname: "Doe"
  --     , role: "Developer"
  --     , job: "Software Engineer"
  --     , phone: "123-456-7890"
  --     , email: "john@example.com"
  --     , portraitId: "portrait123"
  --     }
  --   ]
  --   convertExtractedDataToMembers extractedData === expected

  -- it "handles missing keys by using empty strings" do
  --   let keys = [firstname, lastname] -- Missing role, job, phone, email, portraitId
  --   let keyIndices = arrayToIndexMap keys
  --   let values = [["Alice", "Smith"]]
  --   let extractedData = { keys, keyIndices, values }
  --   let expected = [
  --     { firstname: "Alice"
  --     , lastname: "Smith"
  --     , role: ""
  --     , job: ""
  --     , phone: ""
  --     , email: ""
  --     , portraitId: ""
  --     }
  --   ]
  --   convertExtractedDataToMembers extractedData === expected

  -- it "handles keys in different order" do
  --   let keys = [email, firstname, portraitId, lastname] -- Different order
  --   let keyIndices = arrayToIndexMap keys
  --   let values = [["bob@example.com", "Bob", "portrait456", "Johnson"]]
  --   let extractedData = { keys, keyIndices, values }
  --   let expected = [
  --     { firstname: "Bob"
  --     , lastname: "Johnson"
  --     , role: ""
  --     , job: ""
  --     , phone: ""
  --     , email: "bob@example.com"
  --     , portraitId: "portrait456"
  --     }
  --   ]
  --   convertExtractedDataToMembers extractedData === expected

  -- it "converts multiple members" do
  --   let keys = [firstname, lastname, role]
  --   let keyIndices = arrayToIndexMap keys
  --   let values = [
  --     ["John", "Doe", "Developer"],
  --     ["Alice", "Smith", "Designer"],
  --     ["Bob", "Johnson", "Manager"]
  --   ]
  --   let extractedData = { keys, keyIndices, values }
  --   let expected = [
  --     { firstname: "John", lastname: "Doe", role: "Developer", job: "", phone: "", email: "", portraitId: "" },
  --     { firstname: "Alice", lastname: "Smith", role: "Designer", job: "", phone: "", email: "", portraitId: "" },
  --     { firstname: "Bob", lastname: "Johnson", role: "Manager", job: "", phone: "", email: "", portraitId: "" }
  --   ]
  --   convertExtractedDataToMembers extractedData === expected

  -- it "handles empty values array" do
  --   let keys = [firstname, lastname, role]
  --   let keyIndices = arrayToIndexMap keys
  --   let values = []
  --   let extractedData = { keys, keyIndices, values }
  --   let expected = []
  --   convertExtractedDataToMembers extractedData === expected

  -- it "handles rows with fewer cells than keys" do
  --   let keys = [firstname, lastname, role, job]
  --   let keyIndices = arrayToIndexMap keys
  --   let values = [["John", "Doe"]] -- Missing role and job
  --   let extractedData = { keys, keyIndices, values }
  --   let expected = [
  --     { firstname: "John"
  --     , lastname: "Doe"
  --     , role: ""
  --     , job: ""
  --     , phone: ""
  --     , email: ""
  --     , portraitId: ""
  --     }
  --   ]
  --   convertExtractedDataToMembers extractedData === expected

  -- it "handles rows with more cells than keys" do
  --   let keys = [firstname, lastname]
  --   let keyIndices = arrayToIndexMap keys
  --   let values = [["John", "Doe", "Extra", "Data", "Ignored"]]
  --   let extractedData = { keys, keyIndices, values }
  --   let expected = [
  --     { firstname: "John"
  --     , lastname: "Doe"
  --     , role: ""
  --     , job: ""
  --     , phone: ""
  --     , email: ""
  --     , portraitId: ""
  --     }
  --   ]
  --   convertExtractedDataToMembers extractedData === expected

  -- it "handles empty cells in data" do
  --   let keys = [firstname, lastname, role, job]
  --   let keyIndices = arrayToIndexMap keys
  --   let values = [["", "Smith", "", "Engineer"]]
  --   let extractedData = { keys, keyIndices, values }
  --   let expected = [
  --     { firstname: ""
  --     , lastname: "Smith"
  --     , role: ""
  --     , job: "Engineer"
  --     , phone: ""
  --     , email: ""
  --     , portraitId: ""
  --     }
  --   ]
  --   convertExtractedDataToMembers extractedData === expected

  -- it "handles special characters and spaces in data" do
  --   let keys = [firstname, lastname, email]
  --   let keyIndices = arrayToIndexMap keys
  --   let values = [["Jean-Pierre", "O'Connor", "jean.pierre+test@example.com"]]
  --   let extractedData = { keys, keyIndices, values }
  --   let expected = [
  --     { firstname: "Jean-Pierre"
  --     , lastname: "O'Connor"
  --     , role: ""
  --     , job: ""
  --     , phone: ""
  --     , email: "jean.pierre+test@example.com"
  --     , portraitId: ""
  --     }
  --   ]
  --   convertExtractedDataToMembers extractedData === expected

  -- it "handles data with whitespace (trims)" do
  --   let keys = [firstname, lastname, role]
  --   let keyIndices = arrayToIndexMap keys
  --   let values = [["  John  ", "  Doe  ", "  Developer  "]]
  --   let extractedData = { keys, keyIndices, values }
  --   let expected = [
  --     { firstname: "John"
  --     , lastname: "Doe"
  --     , role: "Developer"
  --     , job: ""
  --     , phone: ""
  --     , email: ""
  --     , portraitId: ""
  --     }
  --   ]
  --   convertExtractedDataToMembers extractedData === expected

  -- it "handles mixed complete and incomplete rows" do
  --   let keys = [firstname, lastname, role, email]
  --   let keyIndices = arrayToIndexMap keys
  --   let values = [
  --     ["John", "Doe", "Developer", "john@example.com"],
  --     ["Alice", "Smith"],
  --     ["Bob", "Johnson", "Manager"]
  --   ]
  --   let extractedData = { keys, keyIndices, values }
  --   let expected = [
  --     { firstname: "John", lastname: "Doe", role: "Developer", job: "", phone: "", email: "john@example.com", portraitId: "" },
  --     { firstname: "Alice", lastname: "Smith", role: "", job: "", phone: "", email: "", portraitId: "" },
  --     { firstname: "Bob", lastname: "Johnson", role: "Manager", job: "", phone: "", email: "", portraitId: "" }
  --   ]
  --   convertExtractedDataToMembers extractedData === expected

  -- it "handles keys with no corresponding values" do
  --   let keys = [job, role, portraitId] -- Keys that don't match any typical data
  --   let keyIndices = arrayToIndexMap keys
  --   let values = [["Engineer", "Developer", "img123"]]
  --   let extractedData = { keys, keyIndices, values }
  --   let expected = [
  --     { firstname: ""
  --     , lastname: ""
  --     , role: "Developer"
  --     , job: "Engineer"
  --     , phone: ""
  --     , email: ""
  --     , portraitId: "img123"
  --     }
  --   ]
  --   convertExtractedDataToMembers extractedData === expected

  -- it "handles duplicate keys (uses first occurrence)" do
  --   let keys = [firstname, firstname, lastname] -- Duplicate firstname
  --   let keyIndices = fromFoldable [Tuple firstname 0, Tuple lastname 2] -- Manual map to simulate first occurrence
  --   let values = [["John", "Johnny", "Doe"]]
  --   let extractedData = { keys, keyIndices, values }
  --   let expected = [
  --     { firstname: "John" -- Uses first occurrence
  --     , lastname: "Doe"
  --     , role: ""
  --     , job: ""
  --     , phone: ""
  --     , email: ""
  --     , portraitId: ""
  --     }
  --   ]
  --   convertExtractedDataToMembers extractedData === expected

  -- it "handles large dataset with all fields" do
  --   let keys = [firstname, lastname, role, job, phone, email, portraitId]
  --   let keyIndices = arrayToIndexMap keys
  --   let values = [
  --     ["John", "Doe", "Developer", "Software Engineer", "123-456-7890", "john@example.com", "portrait1"],
  --     ["Alice", "Smith", "Designer", "UI/UX Designer", "098-765-4321", "alice@example.com", "portrait2"],
  --     ["Bob", "Johnson", "Manager", "Project Manager", "555-123-4567", "bob@example.com", "portrait3"],
  --     ["Carol", "Brown", "Analyst", "Data Analyst", "777-888-9999", "carol@example.com", "portrait4"]
  --   ]
  --   let extractedData = { keys, keyIndices, values }
  --   let expected = [
  --     { firstname: "John", lastname: "Doe", role: "Developer", job: "Software Engineer", phone: "123-456-7890", email: "john@example.com", portraitId: "portrait1" },
  --     { firstname: "Alice", lastname: "Smith", role: "Designer", job: "UI/UX Designer", phone: "098-765-4321", email: "alice@example.com", portraitId: "portrait2" },
  --     { firstname: "Bob", lastname: "Johnson", role: "Manager", job: "Project Manager", phone: "555-123-4567", email: "bob@example.com", portraitId: "portrait3" },
  --     { firstname: "Carol", lastname: "Brown", role: "Analyst", job: "Data Analyst", phone: "777-888-9999", email: "carol@example.com", portraitId: "portrait4" }
  --   ]
  --   convertExtractedDataToMembers extractedData === expected

  -- it "handles completely empty keys and values" do
  --   let keys = []
  --   let keyIndices = arrayToIndexMap keys
  --   let values = []
  --   let extractedData = { keys, keyIndices, values }
  --   let expected = []
  --   convertExtractedDataToMembers extractedData === expected