module App.Component.Page.Seminars.Style.Timeline.Label.Index
  ( style
  ) where

import Proem hiding (top)

import CSS as CSS
import App.Component.Page.Seminars.Style.Timeline.Label.Quoted as Quoted
import App.Component.Page.Seminars.Style.Timeline.Label.Quote as Quote
import App.Component.Page.Seminars.Style.Timeline.Label.Title as Title
import App.Component.Page.Seminars.Style.Timeline.Label.Person as Person
import App.Component.Page.Seminars.Style.Timeline.Label.Names as Names
import App.Component.Page.Seminars.Style.Timeline.Label.Lastname as Lastname

style :: CSS.CSS
style = do
  Quoted.style
  Quote.style
  Title.style
  Person.style
  Names.style
  Lastname.style