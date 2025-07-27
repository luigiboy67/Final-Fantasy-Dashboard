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
                             choices = names(ffdatasets[c(-2,-11,-12)])
                             ),
                 pickerInput("ffname",
                             label = "Choose Monster",
                             choices = purrr::pluck(ffdatasets,1, 1) |> unique()
                             )
      )
      ),
      mainPanel = mainPanel( width = 10,
        div(imageOutput(outputId = "ffmonster"), width = "20%", height = "100%"),
        div(tableOutput("ffmonsterdata"))
      ),
      position = "right"
  )
)

server <- function(input, output, session) {
  session$onSessionEnded(function() { stopApp() })

  ffmonsternames <- reactive({
      switch(
        input$ffdataset,
        "Final_Fantasy_I" = purrr::pluck(ffdatasets,1, 1) |> unique(),
        "Final_Fantasy_III" = purrr::pluck(ffdatasets,3, 1) |> unique(),
        "Final_Fantasy_IV" = purrr::pluck(ffdatasets,4, 1) |> unique(),
        "Final_Fantasy_V" = purrr::pluck(ffdatasets,5, 1) |> unique(),
        "Final_Fantasy_VI" = purrr::pluck(ffdatasets,6, 1) |> unique(),
        "Final_Fantasy_VII" = purrr::pluck(ffdatasets,7, 1) |> unique(),
        "Final_Fantasy_VIII" = purrr::pluck(ffdatasets,8, 1) |> unique(),
        "Final_Fantasy_IX" = purrr::pluck(ffdatasets,9, 1) |> unique(),
        "Final_Fantasy_X" = purrr::pluck(ffdatasets,10, 1) |> unique(),
        "Final_Fantasy_XV" = purrr::pluck(ffdatasets,13, 1) |> unique()
      )
  })

  ffmonsterdata <- reactive({
    switch(
      input$ffdataset,
      "Final_Fantasy_I" = subset(ffdatasets$Final_Fantasy_I, Name == input$ffname),
      "Final_Fantasy_III" = subset(ffdatasets$Final_Fantasy_III, Name == input$ffname),
      "Final_Fantasy_IV" = subset(ffdatasets$Final_Fantasy_IV, Name == input$ffname),
      "Final_Fantasy_V" = subset(ffdatasets$Final_Fantasy_V, Name == input$ffname),
      "Final_Fantasy_VI" = subset(ffdatasets$Final_Fantasy_VI, Name == input$ffname),
      "Final_Fantasy_VII" = subset(ffdatasets$Final_Fantasy_VII, Name == input$ffname),
      "Final_Fantasy_VIII"= subset(ffdatasets$Final_Fantasy_VIII, Name == input$ffname),
      "Final_Fantasy_IX" = subset(ffdatasets$Final_Fantasy_IX, Name == input$ffname),
      "Final_Fantasy_X" = subset(ffdatasets$Final_Fantasy_X, Name == input$ffname),
      "Final_Fantasy_XV" = subset(ffdatasets$Final_Fantasy_XV, Name == input$ffname)
    )
  })


  output$fflogo <- renderImage(
    list(src = paste0("www/logos/", input$ffdataset ,".webp"),
         width = "100%",
         height = "100%"
         ),
    deleteFile = FALSE
  )

  output$ffmonster <- renderImage(
    list(src = paste0("www/",input$ffdataset, "/", input$ffname ,".webp"),
         width = "20%",
         height = "100%"
    ),
    deleteFile = FALSE
  )

  observeEvent(ffmonsternames(), {
    updatePickerInput(
      session,
      "ffname",
      label = "Choose Monster",
      choices = ffmonsternames()
    )
  }
  )

  output$ffmonsterdata <- renderTable(ffmonsterdata())

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
  observe(print(input$ffdataset))
  # observe(print(ffmonsterdata()))
}

shiny::shinyApp(
  ui = ui,
  server = server
)
