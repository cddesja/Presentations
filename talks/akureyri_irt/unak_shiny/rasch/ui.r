# ui.r
shinyUI(fluidPage(
  titlePanel("Rasch Model"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("idiff", label = "Item Difficulty",
                  choices = -3:3, selected = 0)),
    mainPanel(plotOutput("one"))
  )
))