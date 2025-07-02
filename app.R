source("packages.R")
source("data-definitions.R")

ui <- fluidPage(
    sidebarLayout(
      sidebarPanel = sidebarPanel(width = 2,
                                   fluidRow(
                                     imageOutput(outputId = "fflogo", width = "100%", height = "100%")
                                   ),
                                   br(),
        fluidRow(
                 pickerInput("ffdataset",
                             label = "Choose Dataset",
                             choices = c("Final_Fantasy_I")
                             ),
                 pickerInput("ffname",
                             label = "Choose Monster",
                             choices = purrr::pluck(ffdatasets,1, 1)
                             )
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

  # ffrv <- reactiveValues()
  #
  # ffrv$ffdatasets <- names(ffdatasets)
  # ffrv$monster <-


  output$fflogo <- renderImage(
    list(src = paste0("www/logos/", input$ffdataset ,".webp"),
         width = "100%",
         height = "100%"
         ),
    deleteFile = FALSE
  )
  # observeEvent(ffrv$ffdatasets, {
  #   updatePickerInput(
  #     session,
  #     "ffdataset",
  #     label = "Choose Dataset",
  #     choices = ffrv$ffdatasets
  #   )
  # })
  #
  # observeEvent(input$ffdataset, {
  #   ffrv$datasets <- input$ffdataset
  # })
  #
  # observe(print(purrr::pluck(ffdatasets,
  #                            which(ffrv$ffdatasets == input$ffdataset), 1)))

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
