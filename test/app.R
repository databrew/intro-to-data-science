####################################################################
# Shiny app template ###############################################

# Add libraries here
library(shiny)
library(dplyr)
library(gapminder)
library(ggplot2)

# Load data here
gm <- gapminder

####################################################################
ui <- fluidPage(
    titlePanel("The economics of global health"),
    sidebarLayout(
        sidebarPanel(
            selectInput(inputId = 'plot_var',
                        label = 'Choose a variable to plot',
                        choices = c('lifeExp', 'pop', 'gdpPercap'),
                        selected = 'pop'),

            selectInput(inputId = "country_name",
                        label = "Choose a country",
                        choices = unique(gm$country),
                        multiple=TRUE,
                        selected = 'Mexico'),

            sliderInput(inputId = "line_size",
                        label = "Change the thickness of the line",
                        min = 1,
                        max = 10,
                        value =2),

            sliderInput(inputId = "point_size",
                        label = "Change the point size",
                        min = 1,
                        max = 10,
                        value =5),

            sliderInput(inputId = 'alpha_value',
                        label = 'Change transparency of line and points',
                        min= 0,
                        max=1,
                        value =0.5)

        ),
        mainPanel(
            plotOutput("country_plot")
        )
    )
)

####################################################################
server <- function(input,output){

    output$country_plot <- renderPlot({
        cn <- input$country_name
        ps <- input$point_size
        ls <- input$line_size
        av <- input$alpha_value
        pv <- input$plot_var
        pd <- gm %>% dplyr::filter(country == cn)
        ggplot(pd, aes_string('year', pv, color='country')) +
            geom_point(size = ps, alpha=av) +
            geom_line(size = ls, alpha=av) +
            labs(title = cn)
    })
}

####################################################################
shinyApp(ui = ui, server = server)
