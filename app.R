source("packages.R")
source("data-definitions.R")

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

  ffrv <- reactiveValues()

  ffrv$ffdatasets <- names(ffdatasets)


  output$fflogo <- renderImage(
    list(src = paste0("www/logos/", input$ffdataset ,".webp"),
         width = "100%",
         height = "100%"
         ),
    deleteFile = FALSE
  )
  observeEvent(ffrv$ffdatasets, {
    updatePickerInput(
      session,
      "ffdataset",
      label = "Choose Dataset",
      choices = ffrv$ffdatasets
    )
    print(ffrv$datasets)
  })

  observeEvent(input$ffdatasets, {
    ffrv$datasets <- input$ffdatasets
  })

  # observeEvent(input$ffdataset,{
  #   updatePickerInput(
  #     session,
  #     "ffname",
  #     label = "Choose Monster",
  #     choice = ffrv$name
  #   )
  # })
}

shiny::shinyApp(
  ui = ui,
  server = server
)
