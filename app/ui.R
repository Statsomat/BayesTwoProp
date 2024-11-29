# Define UI for application 
shinyUI(fluidPage(
  
  # Disconnect message
  disconnectMessage(
    text = "Your session timed out or out of memory. ",
    refresh = "Reload now",
    background = "#ff9900",
    colour = "white",
    overlayColour = "grey",
    overlayOpacity = 0.3,
    refreshColour = "black"
  ),
  
  # Style uploading modal
  tags$head(tags$style(".modal-body {padding: 10px}
                     .modal-content  {-webkit-border-radius: 6px !important;-moz-border-radius: 6px !important;border-radius: 6px !important;}
                     .modal-dialog { width: 400px; display: inline-block; text-align: center; vertical-align: top;}
                     .modal-header {background-color: #ff9900; border-top-left-radius: 6px; border-top-right-radius: 6px}
                     .modal { text-align: center; padding-right:10px; padding-top: 24px;}
                     .close { font-size: 16px}")),
  
  tags$head(
    tags$style(HTML("
                   .shiny-notification{

                    position: fixed;
                    top: 10px;
                    left: calc(50% - 400px);;
                    width: 950px;
                    /* Make sure it draws above all Bootstrap components */
                    z-index: 2000;
                    background-color: #ff9900;
                
                   }
                
                    ")
               )
    ),
  
  #Disable download button until check positive
  singleton(tags$head(HTML(
    '
  <script type="text/javascript">
    
    
    $(document).ready(function() {
      $("#download").attr("disabled", "true").attr("onclick", "return false;");
      Shiny.addCustomMessageHandler("check_generation", function(message) {
        $("#download").removeAttr("disabled").removeAttr("onclick").html("");
      });
    })
    
  
    
  </script>
  '
  ))),
  
  br(),
  
  tags$div(a(img(src='Logo.jpg', width=200), href="https://www.statsomat.com", target="_blank")),
  
  h1("Two Proportions by Bayes", 
     style = "font-family: 'Helvetica';
     color: #fff; text-align: center;
     background-color: #396e9f;
     padding: 20px;
     margin-bottom: 0px;"),
  h5("Statsomat/BayesTwoProp", 
     style = "font-family: 'Helvetica';
     color: #fff; text-align: center;
     background-color: #2fa42d;
     padding: 5px;
     margin-top: 0px;"),
  
  br(),
  
  fluidRow( 
    
    column(8, offset=2,
           wellPanel(style = "background: #adc7de;", 
                     h3("Choose an Option to Upload the Data"),
                     radioButtons("input_type", "Input type",
                                  choices = list("Upload a CSV File"=1,
                                                 "Insert Frequencies of Occurence"=2)
                                  )
                     ),
           
           conditionalPanel("input.input_type == 1",
                            wellPanel(style = "background: #adc7de;", 
                                      h3("Data by Uploading a CSV File"),
                                      
                                      # File input
                                      fileInput("file", "Choose CSV file",
                                                accept = c(
                                                  "text/csv",
                                                  "text/comma-separated-values",
                                                  ".csv"), 
                                                buttonLabel = "Browse...",
                                                placeholder = "No file selected"),
                                      
                                      # # Input: Select encoding ----
                                      # radioButtons("fencoding", "Encoding",
                                      #              choices = c(Auto = "unknown", 
                                      #                          "UTF-8" = "UTF-8"),
                                      #              selected = "unknown", inline=TRUE),
                                      # 
                                      # # Input: Select decimal ----
                                      # radioButtons("decimal", "Decimal",
                                      #              choices = c(Auto = "auto",
                                      #                          Comma = ",",
                                      #                          Dot = "."),
                                      #              selected = "auto", inline=TRUE),
                                      
                                      h5("Select the Exposure Variable", style="font-weight: bold; font-size: 10pt;"),
                                      uiOutput("selection_exposure"),
                                      
                                      br(),
                                      
                                      selectInput("reference_exposure", "Select the Label for the Existence of the Exposure of Interest", choices = NULL), 
                               
                                      br(),
                                      
                                      h5("Select the Outcome Variable", style="font-weight: bold; font-size: 10pt;"),
                                      uiOutput("selection_outcome"),
                                      
                                      br(),
                                      
                                      selectInput("reference_outcome", "Select the Label for the Existence of the Outcome of Interest", choices = NULL), 
                                      tags$small("By clicking the Browse button and uploading a file, you agree to the",
                                                 style="color: #808080;"),
                                      tags$a(href="https://statsomat.com/terms", target="_blank", "Terms of Use.", style="font-weight: bold; font-size: 9pt;")
                                      )
                            ),
           
           conditionalPanel("input.input_type == 2",
                            wellPanel( 
                              style = "background: #adc7de;", 
                              
                              h3("Data by Entering the Frequencies"),
                              
                              textInput("name_Exposure","Name the Exposure Variable","Exposure"),
                              textInput("name_Outcome","Name the Outcome Variable","Outcome"),
                              
                              h4("Please Insert in the Table Below the Frequencies of Cases"),
                              h5("(type directly in the browser)"),
                              
                              matrixInput("sample",
                                   value = matrix(NA, 2, 2, dimnames = list(c("Non-Outcome","Outcome"), c("Non-Exposure", "Exposure"))),
                                   rows = list(
                                     extend = FALSE,names = TRUE, multiheader=FALSE,editableNames=FALSE),
                                   cols = list(
                                     names = TRUE, multiheader=FALSE,editableNames=FALSE),
                                   class="numeric", lazy=FALSE
                                   ),
                              tags$small("By clicking the Browse button and uploading a file, you agree to the",
                                  style="color: #808080;"),
                              tags$a(href="https://statsomat.com/terms", target="_blank", "Terms of Use.", style="font-weight: bold; font-size: 9pt;")
                              )
                            ),
           
           wellPanel(
             style = "background: #adc7de;", 
             h3("Set Parameters for beta(a1,b1) and beta(a2,b2)"),
             h4("We consider beta(a1,b1) and beta(a2,b2) as prior distributions for Theta1 and Theta2.", style="font-weight: bold; font-size: 11pt;"),
             fluidRow(
               column(6, numericInput("a1", "Value for a1", value = 0.5, min = 0, step = 0.1, width = "100%")),
               column(6, numericInput("b1", "Value for b1", value = 0.5, min = 0, step = 0.1, width = "100%"))
             ),
             
             fluidRow(
               column(6, numericInput("a2", "Value for a2", value = 0.5, min = 0, step = 0.1, width = "100%")),
               column(6, numericInput("b2", "Value for b2", value = 0.5, min = 0, step = 0.1, width = "100%"))
             )
           ),
           
           
           
           wellPanel(style = "background: #ff9900", align="center", 
                     
                     h3("Click to Generate Results"),
                     
                     radioButtons('rcode', '', c('Data Analysis Report (HTML)', 'R Code'), inline = TRUE),
                     actionButton("generate", "", style="
                                    height:145px;
                                    width:84px;
                                    padding-top: 3px;
                                    color:#ff9900; 
                                    background-color: #ff9900; 
                                    background-image: url('Button.gif');
                                    border: none;
                                    outline: none;
                                    box-shadow: none !important;
                                   ")
                     ), 
           
        
           wellPanel(style = "background: #ff9900", align="center", 
                     
                     h3("Click to Download"),
                     
                     downloadButton("download", "", style="
                                    height:145px;
                                    width:84px;
                                    padding-top: 3px;
                                    color:#ff9900; 
                                    background-color: #ff9900; 
                                    border-color: #ff9900;
                                    background-image: url('Button.gif');") 
                     )
           ), # end column 
    
    column(width=2)

    ), # fluidrow
  
  includeHTML("www/Footer.html"),
  
  hr()
  
  ))