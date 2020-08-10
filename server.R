#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
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

# Define server logic required to draw a histogram
function(input, output, session) {
  forest=reactive(
    forest_fires = forest_fires %>%
      mutate(month = factor(month, levels = c("jan", "feb", "mar", "apr", "may", "jun", "jul", "aug", "sep", "oct", "nov", "dec")), 
             day = factor(day, levels = c("sun", "mon", "tue", "wed", "thu", "fri", "sat")))
    ## once have reordered the months and days of the week, you can re-run the bar chart code above
    # to create new bar graphs
  )
}
  output$daysmonths=renderPlot(
    fires_by_month = forest_fires %>%
      group_by(month) %>%
      summarize(total_fires = n()),
    ggplot(data = fires_by_month) +
      aes(x = month, y = total_fires) +
      geom_bar(stat = "identity")  +
      theme(panel.background = element_rect(fill = "white"), 
            axis.line = element_line(size = 0.25, 
                                     colour = "black"))
  )
  output$variables=boxplot(
    create_boxplots = function(x, y) {
      ggplot(data = forest_fires) + 
        aes_string(x = x, y = y) +
        geom_boxplot() +
        theme(panel.background = element_rect(fill = "white"))
    }
    
    ## Assign x and y variable names 
    var_month = names(forest_fires)[3], ## month
    x_var_day = names(forest_fires)[4], ## day
    y_var = names(forest_fires)[5:12],
    ## use the map() function to apply the function to the variables of interest
    map2(x_var_month, y_var, create_boxplots), ## visualize variables by month
    map2(x_var_day, y_var, create_boxplots) ## visualize variables by day
  )
    
  output$affect=scatter.smooth(
    ## write the function 
    create_scatterplots = function(x, y) {
      ggplot(data = forest_fires) + 
        aes_string(x = x, y = y) +
        geom_point() +
        theme(panel.background = element_rect(fill = "white"))
    }
    ## Assign x and y variable names 
    x_var_scatter = names(forest_fires)[5:12],
    y_var_scatter = names(forest_fires)[13],
    ## use the map() function to apply the function to the variables of interest
    map2(x_var_scatter, y_var_scatter, create_scatterplots)
  )
  
  

