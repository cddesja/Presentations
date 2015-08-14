# ui.r
shinyUI(fluidPage(
  titlePanel("2PL IRT model"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("diff", label = "Item Difficulty",
                  choices = -3:3),
      selectInput("disc", label = "Item Discrimination",
                  choices = -3:3)),
    mainPanel(plotOutput("twopl"))
  )
))