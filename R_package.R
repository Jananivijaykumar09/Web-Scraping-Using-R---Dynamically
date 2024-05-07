library(shiny)
library(rvest)
library(stringr)

# Define UI
ui <- fluidPage(
  titlePanel("Web Information Scraper"),
  sidebarLayout(
    sidebarPanel(
      textInput("any_url", "Enter ANY URL TO SCRAPE:", ""),  # Changed input ID
      actionButton("scrape_button", "Scrape WEB Info")
    ),
    mainPanel(
      verbatimTextOutput("scraped_output")
    )
  )
)

# Define server logic
server <- function(input, output) {
  # Function to scrape movie information
  scrape_movie_info <- function(any_url) {
    # Read the HTML content from the URL
    page <- read_html(any_url)
    
    # Check if the page is successfully loaded
    if (is.null(page)) {
      return("Error: Unable to load the page. Please check the URL.")
    }
    
    # Specify the full file path
    file_path <- "Scrape.html"  # Changed file path
    
    # Save the HTML content to a file
    writeLines(as.character(page), file_path)
    
    # Return the file path
    return(file_path)
  }
  
  # Event handler for scraping button click
  observeEvent(input$scrape_button, {
    any_url <- input$any_url
    
    # Call the function to scrape movie information
    scraped_file <- scrape_movie_info(any_url)  # Corrected function name
    
    # Output the result
    output$scraped_output <- renderText({
      if (!is.null(scraped_file)) {
        paste("The HTML content of the page has been saved to:", scraped_file)
      } else {
        "Error: Unable to scrape movie information."
      }
    })
  })
}

# Run the application
shinyApp(ui = ui, server = server)
