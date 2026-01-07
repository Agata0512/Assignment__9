library(shiny)

fluidPage(
  titlePanel("Gene Expression"),
  sidebarLayout(
    sidebarPanel(
      selectInput(  
        "gene_id",
        "Select Gene ID:",
        choices = NULL 
      )
    ),
    mainPanel(
      plotOutput("gene_Plot")  
    )
  )
)
