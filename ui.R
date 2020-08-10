#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(readr)
library(dplyr)
library(ggplot2)
library(purrr)
library(datasets)

forest_fires = read_csv("forestfires.csv")

fluidPage(
    titlePanel("Forest Fires Data Analysis"),
    navlistPanel(
        tabPanel(panelId="daysmonths",
                 title="Days and Months",),
        tabPanel(panelId = "variables",
                 title="Variables based on days and months"),
        tabPanel(panelId = "affect",
                 title="Variables affect the size of fires")
    )
          
)