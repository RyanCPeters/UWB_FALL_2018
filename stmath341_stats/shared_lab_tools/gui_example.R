# Create example data

set.seed(10)
MeasurementA <- rnorm(1000, 5, 2)
MeasurementB <- rnorm(1000, 5, 2)
Wafer <- rep(c(1:100), each=10)
ID <- rep(c(101:200), each=10)
Batch <- rep(LETTERS[seq(from=1, to =10)], each=100)
Date <- rep(seq(as.Date("2001-01-01"), length.out = 100, by="1 day"), each=10)

# Add data for Wafer 1 with a new date

W2 <- rep(1, each=10)
ID2 <- rep(101, each=10)
Batch2 <- rep("A", each=10)
Date2 <- rep(as.Date("2001-04-11"), each=10)
MA2 <- rnorm(10, 5, 2)
MB2 <- rnorm(10, 5, 2)

df <- data.frame(Batch, Wafer, ID, MeasurementA, MeasurementB, Date)
ee <- data.frame(Batch2, W2, ID2, MA2, MB2, Date2)
colnames(ee) <- c("Batch", "Wafer", "ID", "MeasurementA", "MeasurementB", "Date")

# Data frame now how two sets of date for Wafer 1 on different dates
dd <- rbind(df, ee)
dd$Date <- factor(dd$Date)


# Create local connection (in reality this will be a connection to a host site)

con <- dbConnect(RSQLite::SQLite(), ":memory:")
dbWriteTable(con, "dd", dd)
query <-  function(...) dbGetQuery(con, ...)

# Create empty data frames to populate

wq = data.frame()
sq = data.frame()

shinyServer(function(input, output){
  
  # create data frame to store reactive data set from query
  values <- reactiveValues()
  values$df <- data.frame()
  
  # Action button for first query
  d <- eventReactive(input$do, { input$wafer })
  
  # First stage of reactive query
  a <- reactive({ paste("Select ID from dd where Wafer=",d(), sep="") })
  
  wq <- reactive({  query( a() ) })
  
  # Output to confirm query is correct
  output$que <- renderPrint({ a() }) 
  output$pos <- renderPrint( wq()[1,1] )  
  
  # Action button to add results from query to a data frame
  e <- eventReactive(input$do2, { wq()[1,1] })
  
  b <- reactive({ paste("select cast(Wafer as varchar) as Wafer, cast(Batch as varchar) as Batch, MeasurementA, MeasurementB, Date from dd where ID=",e()," Order by  ID asc ;", sep="") })
  
  # observe e() so that data is not added until user presses action button  
  observe({
    if (!is.null(e())) {
      sq <- reactive({  query( b() ) })
      
      # add query to reactive data frame
      values$df <- rbind(isolate(values$df), sq())
    }
  })
  
  
  
  asub <- eventReactive(input$do3,{subset(values$df, MeasurementA > input$Von[1] & MeasurementA < input$Von[2] )})
  
  observeEvent(input$do4, {
    
    values$df <- NULL
    
  })
  
  output$boxV <- renderPlot({
    ggplot(asub(), aes_string('Wafer', input$char, fill='Batch')) + geom_boxplot() 
  })
  
})

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


shinyUI(
  fluidPage(
    titlePanel("Generic grapher"), 
    sidebarLayout(
      sidebarPanel(
        numericInput("wafer", label = h3("Input wafer ID:"), value = NULL),
        actionButton("do", "Search wafer"),
        actionButton("do2", "Add to data frame"),
        actionButton("do3", "Show"),
        actionButton("do4", "Clear"),
        selectInput("char", label="Boxplot choice:", choices = list("A"="MeasurementA", "B"="MeasurementB"), selected="Von.fwd"),
        sliderInput("Von", label = "A range:", min=0, max=10, value=c(0,10), step=0.1)
        ),
    
    mainPanel(
      verbatimTextOutput("que"), 
      verbatimTextOutput("pos"),
      plotOutput("boxV")
      #dataTableOutput(outputId="posi")
      )
    )
  )
)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

