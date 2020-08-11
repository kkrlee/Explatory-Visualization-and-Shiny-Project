library(shiny)
# use the below options code if you wish to increase the file input limit, in this example file input limit is increased from 5MB to 9MB
# options(shiny.maxRequestSize = 9*1024^2)

shinyServer(function(input,output){
    
    # This reactive function will take the inputs from UI.R and use them for read.table() to read the data from the file. It returns the dataset in the form of a dataframe.
    # file$datapath -> gives the path of the file
    data <- reactive({
        file1 <- input$file
        if(is.null(file1)){return()} 
    })
    
    # this reactive output contains the summary of the dataset and display the summary in table format
    output$filedf <- renderTable({
        if(is.null(data())){return ()}
        input$file
    })
    output$bplot1 <- renderPlot({
        if (input$months1 == TRUE){
            forest_fires %>%
                group_by(month) %>%
                summarize(total_fires = n()) %>% 
                ggplot() +
                aes(x = month, y = total_fires) +
                geom_bar(stat = "identity")  +
                theme(panel.background = element_rect(fill = "white"), 
                      axis.line = element_line(size = 0.25, 
                                               colour = "black"))  
        }
        
        
    })
    output$bplot2<- renderPlot({
        if (input$days1 == TRUE){
            forest_fires %>%
                group_by(day) %>%
                summarize(total_fires = n()) %>% 
                ggplot() +
                aes(x = day, y = total_fires) +
                geom_bar(stat = "identity") +
                theme(panel.background = element_rect(fill = "white"), 
                      axis.line = element_line(size = 0.25, 
                                               colour = "black")) 
        }
    })
    output$boxplot<- renderPlot({
        if (input$variables == TRUE){
            create_boxplots = function(x, y) {
                ggplot(data = forest_fires) + 
                    aes_string(x = x, y = y) +
                    geom_boxplot() +
                    theme(panel.background = element_rect(fill = "white"))
            }
            ## Assign x and y variable names 
            x_var_month = names(forest_fires)[3] ## month
            x_var_day = names(forest_fires)[4] ## day
            y_var = names(forest_fires)[5:12]
            ## use the map() function to apply the function to the variables of interest
            map2(x_var_month, y_var, create_boxplots) ## visualize variables by month
            map2(x_var_day, y_var, create_boxplots) ## visualize variables by day
        }
    })
    output$scatterplot<-renderPlot({
        if (input$affect == TRUE){
            ## write the function 
            create_scatterplots = function(x, y) {
                ggplot(data = forest_fires) + 
                    aes_string(x = x, y = y) +
                    geom_point() +
                    theme(panel.background = element_rect(fill = "white"))
            }
            ## Assign x and y variable names 
            x_var_scatter = names(forest_fires)[5:12]
            y_var_scatter = names(forest_fires)[13]
            ## use the map() function to apply the function to the variables of interest
            map2(x_var_scatter, y_var_scatter, create_scatterplots)  
        }
    })
    
    
})