library(shiny)
shinyUI(fluidPage(
    titlePanel("Forest Fires"),
    sidebarLayout(
        sidebarPanel(
            fileInput("file","Upload the file"), # fileinput() function is used to get the file upload contorl option
            helpText("Default max. file size is 5MB"),
            tags$hr(),
            h5(helpText("Initial Exploration")),
            checkboxInput(inputId = 'months1', label = 'Months', value = FALSE),
            checkboxInput(inputId = "days1", label="Days", FALSE),
            h5(helpText("Analyzing Variables")),
            checkboxInput(inputId = 'variables', label = '', value = FALSE),
            h5(helpText("Variables Affect the Size of Fires")),
            checkboxInput(inputId = "affect", label="", FALSE),
            br()
        ),
        mainPanel(
            plotOutput("bplot1"),plotOutput("bplot2"),
            plotOutput("boxplot"),
            plotOutput("scatterplot")
            
        )
        
    )
))