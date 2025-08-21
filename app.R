source("packages.R")
source("data-definitions.R")

ui <- page_sidebar(
                    title = "Final Fantasy Dashboard",
                    sidebar = sidebar( position = "right",
                      imageOutput(outputId = "fflogo", width = "100%", height = "100%"),
                      pickerInput("ffdataset",
                                  label = "Choose Dataset",
                                  choices = names(ffdatasets)
                      ),
                      pickerInput("ffname",
                                  label = "Choose Monster",
                                  choices = purrr::pluck(ffdatasets,1, 1) |> unique()
                      )
                    ),
                    column(width = 4,
                    card(
                      div(imageOutput(outputId = "ffmonster"), width = "100%", height = "100%", fill = TRUE)
                      )
                    ),
                    column(
                      width = 6,
                      card(
                        div(tableOutput("ffmonsterdata"))
                      )
                    )
                  )
server <- function(input, output, session) {
  session$onSessionEnded(function() { stopApp() })

  ffmonsternames <- reactive({
      switch(
        input$ffdataset,
        "Final_Fantasy_I" = purrr::pluck(ffdatasets,1, 1) |> unique(),
        "Final_Fantasy_III" = purrr::pluck(ffdatasets,2, 1) |> unique(),
        "Final_Fantasy_IV" = purrr::pluck(ffdatasets,3, 1) |> unique()
      )
  })

  ffmonsterdata <- reactive({
    switch(
      input$ffdataset,
      "Final_Fantasy_I" = subset(ffdatasets$Final_Fantasy_I, Name == input$ffname),
      "Final_Fantasy_III" = subset(ffdatasets$Final_Fantasy_III, Name == input$ffname),
      "Final_Fantasy_IV" = subset(ffdatasets$Final_Fantasy_IV, Name == input$ffname)
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
         width = "100%",
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

  output$ffmonsterdata <- renderTable(ffmonsterdata(),
                                      width = "100%"
                                      )
}

shiny::shinyApp(
  ui = ui,
  server = server
)
