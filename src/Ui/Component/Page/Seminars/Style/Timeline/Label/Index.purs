module Ui.Component.Page.Seminars.Style.Timeline.Label.Index
  ( style
  ) where

import Proem hiding (top)

import CSS as CSS
import Ui.Component.Page.Seminars.Style.Timeline.Label.Quoted as Quoted
import Ui.Component.Page.Seminars.Style.Timeline.Label.Quote as Quote
import Ui.Component.Page.Seminars.Style.Timeline.Label.Title as Title
import Ui.Component.Page.Seminars.Style.Timeline.Label.Person as Person
import Ui.Component.Page.Seminars.Style.Timeline.Label.Names as Names
import Ui.Component.Page.Seminars.Style.Timeline.Label.Lastname as Lastname

style :: CSS.CSS
style = do
  Quoted.style
  Quote.style
  Title.style
  Person.style
  Names.style
  Lastname.style