#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#
library(shiny)
library(ggplot2)

function(input, output, session) {
  
#loading the data
  inp_data <- reactive({
    data <- read.csv("TPMs_table_100genes.csv", stringsAsFactors = FALSE)
    print(paste("Data loaded:", nrow(data), "genes"))  # ADD THIS LINE
    return(data)
  })
  
  observe({
    data <- inp_data()
    gene_ids <- data[[1]]
    updateSelectInput(session, "gene_id",
                      choices = gene_ids,
                      selected = gene_ids[1])
  })
  
#rendering the plot
  output$gene_Plot <- renderPlot({
    req(input$gene_id)
    data <- inp_data()
    
    gene_row <- data[data[[1]] == input$gene_id, ]
        plot_df <- data.frame(
      Sample = names(gene_row)[-1],
      TPM = as.numeric(gene_row[1, -1])
    )
    
    ggplot(plot_df, aes(x = Sample, y = TPM)) +
      geom_col(fill = "blue") +
      ggtitle(paste("Expression for Gene:", input$gene_id)) +
      xlab("Sample") +
      ylab("TPM") +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
  })
}
