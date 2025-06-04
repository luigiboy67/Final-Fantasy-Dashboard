source("packages.R")

ui <- fluidPage(
  fluidRow(
    imageOutput(outputId = "fflogo")
    ),
  fluidRow(
    sidebarLayout(
      sidebarPanel = sidebarPanel(
        pickerInput("ffdataset",
                    label = "Choose Dataset",
                    choices = NULL),
        pickerInput("ffname",
                    label = "Choose Monster",
                    choices = NULL)
      ),
      mainPanel = mainPanel(
        div(imageOutput(outputId = "ffmonster")),
        div(DT::dataTableOutput("ffmonsterdata"))
      ),
      position = "right"
  ))
)

server <- function(input, output, session) {

  output$fflogo <- renderImage(
    list(src = "www/logos/Main-Series/Final-Fantasy-1.webp",
         width = "250px",
         height = "100px"
         ),
    deleteFile = FALSE
  )
}

shiny::shinyApp(
  ui = ui,
  server = server
)
