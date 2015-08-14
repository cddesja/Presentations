# ui.r
shinyUI(fluidPage(
  titlePanel("3PL IRT model"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("diff", label = "Item Difficulty",
                  choices = -3:3),
      selectInput("disc", label = "Item Discrimination",
                  choices = -3:3),
    selectInput("guess", label = "Guessing",
                choices = seq(0, 1, by = .25))),
    mainPanel(plotOutput("threepl"))
  )
))