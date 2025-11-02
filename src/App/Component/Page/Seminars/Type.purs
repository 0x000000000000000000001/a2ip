module App.Component.Page.Seminars.Type where

import Proem

import App.Component.Common.Fragment.Type as Fragment
import App.Component.Common.Modal.Type as Modal
import App.Component.Common.Timeline.Type as Timeline
import App.Component.Common.YoutubeVideo.Type as YoutubeVideo
import App.Component.Util.Email (emailOfJoel, emailOfSophie)
import App.Component.Util.Type (NoInput, NoOutput, NoQuery, NoSlotAddressIndex, Remote)
import App.Util.Capability.AppM (AppM)
import Data.Date (Date)
import Data.Generic.Rep (class Generic)
import Data.Lens (Lens')
import Data.Maybe (Maybe(..))
import Data.Show.Generic (genericShow)
import Halogen (HalogenM, Slot)
import Util.Time (unsafeDate)
import Data.String.Read (class Read)

type Input = NoInput

type Output = NoOutput

type Slots =
  ( timeline :: Slot Timeline.Query Timeline.Output NoSlotAddressIndex
  , youtubeVideo :: Slot YoutubeVideo.Query YoutubeVideo.Output NoSlotAddressIndex
  , themeDescription :: Slot Fragment.Query (Modal.Output Fragment.Output) NoSlotAddressIndex
  )

type State 
  = Remote 
      { seminars :: Array Seminar
      , selectedSeminar :: 
          Maybe 
            { seminar :: Seminar
            , openThemeDescriptionModal :: Boolean
            }
      }

_seminars = identity :: Lens' State State

data Action 
  = Load 
  | SelectSeminar (Maybe Seminar)
  | SelectSeminarByDate (Maybe Date)
  | OpenThemeDescriptionModal
  | CloseThemeDescriptionModal
  | DoNothing

type Query :: ∀ k. k -> Type
type Query = NoQuery

type SeminarsM a = HalogenM State Action Slots Output AppM a

type SeminarRow = 
  ( title :: String
  , theme :: Theme
  , firstname :: String
  , lastname :: String
  , date :: Date
  , videoUrl :: String
  )

type Seminar = { | SeminarRow }

mockDates :: Array Date
mockDates = 
  [ { d: 1, m: 1, y: 2024 }
  , { d: 15, m: 2, y: 2024 }
  , { d: 10, m: 3, y: 2024 }
  , { d: 5, m: 4, y: 2024 }
  , { d: 20, m: 5, y: 2024 }
  , { d: 30, m: 6, y: 2024 }
  , { d: 25, m: 7, y: 2024 }
  , { d: 15, m: 8, y: 2024 }
  , { d: 10, m: 9, y: 2024 }
  , { d: 5, m: 10, y: 2024 }
  , { d: 20, m: 11, y: 2024 }
  , { d: 31, m: 12, y: 2024 }
  ] <#> \{ d, m, y } -> unsafeDate y m d

type ThemeInfo = 
  { name :: String
  , description :: String
  , contactEmail :: String 
  , parent :: Maybe Theme
  , children :: Maybe (Array Theme)
  }

data Theme 
  = Politics
  | Discontents 
  | History
  | WorldViews

derive instance eqTheme :: Eq Theme
derive instance genericTheme :: Generic Theme _
instance showTheme :: Show Theme where
  show = genericShow

instance Read Theme where
  read "Politics" = Just Politics
  read "Discontents" = Just Discontents
  read "History" = Just History
  read _ = Nothing

themeInfo :: Theme -> ThemeInfo
themeInfo = case _ of
  Politics -> 
    { name: "Politique et religion"
    , description: "L’objet de ce séminaire est d’interroger à partir de de la psychanalyse l’interrelation des deux champs du religieux et du politique dans le monde d’aujourd’hui. Nombreux sont les textes de Freud dans lesquels il s’affronte à la question politique au travers d’occurrences diverses : la civilisation, l’idéologie, le lien social et surtout la guerre. Quant à la question religieuse, lui qui se disait juif et athée, elle le poursuivra toute sa vie, portant comme une énigme ce « sentiment océanique » qu’il se refusait à partager avec le pasteur Pfister. Sans se limiter à Freud, on travaillera, notamment avec les psychanalystes du courant freudo-marxiste, l’articulation de ces deux questions : comment comprendre les affects qui soutiennent aujourd’hui les systèmes politiques articulés sur une religion et un chef religieux aussi bien que ceux qui, sans référence à une dimension religieuse explicite, vouent à un chef politique un investissement et une confiance intégrale dans sa capacité de guide. Ces interrogations auraient pu devenir obsolètes dans le monde « désenchanté «  du système économique mondialisé mais elles n’ont cependant pas disparu pour autant  et leur compréhension du point de vue de la psychanalyse est nécessaire."
    , contactEmail: emailOfSophie
    , parent: Nothing
    , children: Nothing
    }
  Discontents ->
    { name: "Malaise dans la civilisation aujourd’hui"
    , description: "Le projet est de reprendre le thème du texte de Freud « Das Unbehagen in der Kultur » ( 1929) non pas pour en faire une fois de plus l’exégèse de son contenu mais pour s’interroger sur la pertinence aujourd’hui de la place qu’il donne au sentiment de culpabilité dans le développement et le maintien de la civilisation qui impliquerait, selon lui, un renoncement au moins partiel au bonheur. La crise sanitaire et ses mantras (« Prenez soin de vous », « Profitez bien ») semble avoir encore accentué à l’inverse une idéologie déjà solidement ancrée dans des principes benthamiens basés sur l’utilité c’est-à-dire le calcul qui permet d’écarter la souffrance et d’accroître le plaisir. Parallèlement les partisans de la décroissance nous alertent sur les risques devenus réalité de l’autodestruction de la planète par la surconsommation de l’énergie non renouvelable entraînant la catastrophe climatique jointe à celle de la surpopulation et aux migrations liées à la famine. La question porterait donc sur le « malaise » d’aujourd’hui et surtout sur la pertinence de la place à donner ou non à la culpabilité comme vecteur civilisationnel ainsi que sur la définition du bonheur telle qu’elle pourrait être donnée près d’un siècle après l’écriture de ce texte de Freud dont il disait à Lou Andreas Salomé qu’il lui avait fait « redécouvrir les vérités les plus banales »."
    , contactEmail: emailOfSophie
    , parent: Nothing
    , children: Nothing
    }
  History ->
    { name: "Écrire l’histoire de la psychanalyse"
    , description: "Ce séminaire international, interdisciplinaire et inter-sociétés reprend le fil d’un travail collectif inauguré en 1985 par l’Association Internationale d’Histoire de la Psychanalyse (AIHP). Construire son histoire est une nécessité pour tout sujet et tout groupe afin de se penser et de s'auto-investir dans une réalité qui les dépasse et va les effacer dans l’oubli. Mais l’écriture de l’Histoire, même partielle, ne se limite pas à raconter des histoires. Pourtant, l’histoire de la psychanalyse bien souvent ressemble à des histoires de famille, ce qui incitera à se demander la place qu’y tiennent le secret, l’anecdote, la révélation fracassante. Les relations personnelles des psychanalystes avec leurs passions se sont souvent entrecroisées avec l’histoire des concepts ce qui ne manque pas de reposer la question du statut de cette histoire. Comme toute histoire partielle, l’histoire de la psychanalyse doit aussi être située à l’intérieur de l’Histoire dans sa dimension sociétale et géopolitique et cette dimension devrait nous conduire à une réflexion sur l’avenir. Prévu pour trois années, ce séminaire abordera les thèmes suivants :  Les histoires de la psychanalyse, Les outils pour écrire l’histoire de la psychanalyse, les apparitions et disparitions dans l’histoire de la psychanalyse, les médiations et transmissions dans l’histoire de la psychanalyse, la place de l’histoire de la psychanalyse dans l’Histoire."
    , contactEmail: emailOfSophie
    , parent: Nothing
    , children: Just [WorldViews]
    }
  WorldViews ->
    { name: "Visions-du-monde dans les théorisations en psychanalyse"
    , description: "Pourquoi existe-t ‘il autant de théories psychanalytiques pour un même objet ? Pourquoi ces différences, que l’on pourrait accueillir comme autant de points de vue à rassembler, sont-elles sources de conflits, parfois virulents, voire de scissions ? Pour tenter d’y répondre, cela nous amène à relever les fondements qui orientent une pensée, une théorie ou son auteur, c'est-à-dire rechercher des présupposés, qu’ils soient : D’origines externes : socioculturels, linguistiques, religieux, politiques, effets des emprunts à d’autres sciences, etc. ; D’origines internes : c'est-à-dire au service de problématiques personnelles, que Freud a pu nommer mythes endopsychiques puis visions-du-monde, et qui expliqueraient que nous avons en ce cas à faire à des théories identitaires (donc pour-soi, au service de préférences pulsionnelles), sources de conflits d’identités (et donc parfois « conflits pulsionnels »). "
    , contactEmail: emailOfJoel
    , parent: Just History
    , children: Nothing
    }