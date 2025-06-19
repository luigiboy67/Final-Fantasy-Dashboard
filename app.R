source("packages.R")

ui <- fluidPage(
    sidebarLayout(
      sidebarPanel = sidebarPanel( width = 2,
                                   fluidRow(
                                     imageOutput(outputId = "fflogo", width = "100%", height = "100%")
                                   ),
                                   br(),
        fluidRow(
                 pickerInput("ffdataset",
                             label = "Choose Dataset",
                             choices = NULL),
                 pickerInput("ffname",
                             label = "Choose Monster",
                             choices = NULL)

                 )
      ),
      mainPanel = mainPanel( width = 10,
        div(imageOutput(outputId = "ffmonster")),
        div(DT::dataTableOutput("ffmonsterdata"))
      ),
      position = "right"
  )
)

server <- function(input, output, session) {

  output$fflogo <- renderImage(
    list(src = paste0("www/logos/", input$ffdataset ,".webp"),
         width = "100%",
         height = "100%"
         ),
    deleteFile = FALSE
  )
}

shiny::shinyApp(
  ui = ui,
  server = server
)
