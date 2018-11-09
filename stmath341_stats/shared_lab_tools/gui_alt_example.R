

if (!require("pkgload")) install.packages('pkgload')
devtools::load_all()
if (!require("DT")) install.packages('DT')
library(DT)
devtools::session_info()
rm(list = ls())
library(shiny)
library(DT)

ui <- fluidPage(
  
  # Inlcude the line below in ui.R so you can send messages
  tags$head(tags$script(HTML('Shiny.addCustomMessageHandler("jsCode",function(message) {eval(message.value);});'))),
  titlePanel("Pop-up Alerts"),
  sidebarPanel(
    sliderInput("my_slider", "Range Slider:", min = 0, max = 150, value = 40, step=1),
    dateInput('my_daterange',label = '',value = Sys.Date()),
    actionButton("run","Execute")),
  mainPanel(DT::dataTableOutput('tbl'))
)

server <- function(input, output, session) {
  
  # Alert below will trigger if the slider is over 100
  observe({
    if(input$my_slider >= 100)
    {
      my_slider_check_test <- "Your slider value is above 100 - no data will be displayed"
      js_string <- 'alert("SOMETHING");'
      js_string <- sub("SOMETHING",my_slider_check_test,js_string)
      session$sendCustomMessage(type='jsCode', list(value = js_string))
    }
  })
  
  
  # Alert below about dates will notify you if you selected today
  observe({
    if (is.null(input$run) || input$run == 0){return()}
    isolate({
      input$run
      if(input$my_daterange == Sys.Date())
      {
        my_date_check_test <- "Today Selected"
        js_string <- 'alert("SOMETHING");'
        js_string <- sub("SOMETHING",my_date_check_test,js_string)
        session$sendCustomMessage(type='jsCode', list(value = js_string))
      }
      # Alert will also trigger and will notify about the dates
      if(input$my_daterange == Sys.Date())
      {
        my_date_check_test <- paste0("You selected: ",input$my_daterange)
        js_string <- 'alert("SOMETHING");'
        js_string <- sub("SOMETHING",my_date_check_test,js_string)
        session$sendCustomMessage(type='jsCode', list(value = js_string))
      }
      
    })
  })
  
  my_data <- reactive({
    
    if(input$run==0){return()}
    isolate({
      input$run
      if(input$my_slider >= 100)
      {
        # Alert below will trigger if you adjusted the date but slider is still 100
        my_slider_check_test <- "Slider is still over 100"
        js_string <- 'alert("SOMETHING");'
        js_string <- sub("SOMETHING",my_slider_check_test,js_string)
        session$sendCustomMessage(type='jsCode', list(value = js_string))
      }
      if(input$my_slider < 100)
      {
        iris[1:input$my_slider,]
      }
    })  
  })
  output$tbl = DT::renderDataTable(my_data(), options = list(lengthChange = FALSE))
}

shinyApp(ui = ui, server = server)
