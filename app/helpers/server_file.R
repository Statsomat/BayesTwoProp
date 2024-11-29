
# Define server logic 
server_file <- function(input, output, session) {
  
  # Reload app if disconnected
  observeEvent(input$disconnect, {
    session$close()
    })
  
  # Reload app button
  observeEvent(input$reload,session$reload())
  
  # On session end
  session$onSessionEnded(stopApp)
  
  # Upload message
  observeEvent(input$file, 
               once=T,
               ignoreInit=T,
               {showModal(modalDialog(
                 title = "Reading Data", "Please Wait",
                 footer = NULL,
                 fade = FALSE,
                 easyClose = TRUE
                 ))
                 Sys.sleep(2)}, 
               priority=100)
  
  # Upload data
  datainput <- reactive({ 
        
  ### Validations ###
    
    validate(need(input$file$datapath != "", "Please upload a CSV file."))
    validate(need(tools::file_ext(input$file$datapath) == "csv", "Error. Not a CSV file. Please upload a CSV file."))
        
    # if (input$fencoding == "unknown"){
    #   
    #   validate(need(try(datainput1 <- fread(input$file$datapath, 
    #                                         header = "auto", 
    #                                         sep="auto", 
    #                                         dec=".", 
    #                                         encoding = "unknown",
    #                                         data.table = FALSE, 
    #                                         na.strings = "")),
    #                 "Error. File cannot be read. Please check that the file is not empty, fully whitespace, or skip has been set after the last non-whitespace."
    #                 )
    #            )
    #       
    #   validate(need(tryCatch(datainput1 <- fread(input$file$datapath, 
    #                                              header = "auto", 
    #                                              sep="auto", 
    #                                              dec=".", 
    #                                              encoding = "unknown", 
    #                                              data.table = FALSE, 
    #                                              na.strings = ""), 
    #                          warning=function(w) {}),
    #                 "Error. The file cannot be read unambigously. Check the characters for the field separator, quote or decimal. Remove blank lines. "
    #                 )
    #            )
    #   
    #   validate(need(try(iconv(colnames(datainput1), guess_encoding(input$file$datapath)[[1]][1], "UTF-8")),
    #                 "Error. Encoding cannot be converted. Please revise your data or try other upload options."
    #                 )
    #            )
    #   
    #   validate(need(try(sapply(datainput1[, sapply(datainput1, is.character)], function(col) iconv(col, guess_encoding(input$file$datapath)[[1]][1], "UTF-8"))),
    #                 "Error. Encoding cannot be converted. Please revise your data or try other upload options."
    #                 )
    #            )
    # 
    #   }
    # 
    # if (input$fencoding == "UTF-8"){
    #   
    #   validate(need(guess_encoding(input$file$datapath)[[1]][1] %in% c("UTF-8","ASCII") & 
    #                   guess_encoding(input$file$datapath)[[2]][1] > 0.9,
    #                 "Error. The file is probably not UTF-8 encoded. Please convert to UTF-8 or try the automatic encoding option."
    #                 )
    #            )
    #   
    #   validate(need(try(datainput1 <- fread(input$file$datapath, 
    #                                         header = "auto", 
    #                                         sep="auto", 
    #                                         dec=".", 
    #                                         encoding = "UTF-8", 
    #                                         data.table = FALSE, 
    #                                         na.strings = "")), 
    #                 "Error. File cannot be read. Please check that the file is not empty, fully whitespace, or skip has been set after the last non-whitespace."
    #                 )
    #            )
    #    
    #   validate(need(tryCatch(datainput1 <- fread(input$file$datapath, 
    #                                              header = "auto", 
    #                                              sep="auto", 
    #                                              dec=".", 
    #                                              encoding = "unknown", 
    #                                              data.table = FALSE, 
    #                                              na.strings = ""), warning=function(w) {}),
    #                 "Error. The file cannot be read unambigously. Check the characters for the field separator, quote or decimal. Remove blank lines. "
    #                 )
    #            )
    #       
    #     }
    
    if (is.null(input$file))
      return(NULL)
    
    ### Data Input ###
    
    return(tryCatch({
      
      enc_guessed <- guess_encoding(input$file$datapath)
      enc_guessed_first <- enc_guessed[[1]][1]
      
      datainput1 <- fread(input$file$datapath, 
                          header = "auto", 
                          sep="auto", 
                          dec ="auto", 
                          encoding = "unknown", 
                          data.table = FALSE, 
                          na.strings = "")
      
      colnames(datainput1) <- iconv(colnames(datainput1), enc_guessed_first, "UTF-8")
      col_names <- sapply(datainput1, is.character)
      
      datainput1[ ,col_names] <- sapply(datainput1[, col_names], function(col) iconv(col, enc_guessed_first, "UTF-8"))
      datainput1}
      ,error=function(e) stop(safeError(e))
      
      ))
    }
  )
  
  # Row limits 
  observe({
    req(input$file, datainput())
    removeModal()
    
    if (nrow(datainput()) > 100000){
      showNotification("Maximum sample size exceeded. ", duration=30)
      Sys.sleep(5)
      session$close()
      }
    
    if (nrow(datainput()) < 1){ # Vorruebergehend auf 1 gesetzt
      showNotification("Error: Minimum 20 observations required. ", duration=30)
      Sys.sleep(5)
      session$close()
      }
    })
  
  # Select Exposure Variable
  #To dynamically scale selection window
  selection_length_min = 7
  selection_length_max = 15
  
  output$selection_exposure <- renderUI({
    
    req(datainput())
    removeModal()
    
    chooserInput("selection_exposure", "Available", "Selected",
                 colnames(datainput()), c(),
                 size = min(c(max(c(length(colnames(datainput())), selection_length_min)), selection_length_max)), 
                 multiple = FALSE)
    
    })
  
  observeEvent(input$selection_exposure, {
    
    factorinterest <- input$selection_exposure$right
    choices <-  unique(datainput()[,factorinterest])  
    updateSelectInput(session = getDefaultReactiveDomain(), inputId = "reference_exposure", choices = choices)
    
    })
  
  referencename_exposure <- reactive({
    
    req(input$reference_exposure)
    input$reference_exposure
    
    })
  
  # Select Outcome Variable
  output$selection_outcome <- renderUI({
    
    req(datainput())
    removeModal()
    
    chooserInput("selection_outcome", "Available", "Selected",
                 colnames(datainput()), c(), size = min(c(max(c(length(colnames(datainput())), selection_length_min)), selection_length_max)), multiple = FALSE)
      
    })
  
  #  Dynamic component for the reference level of the factor of interest
  
  observeEvent(input$selection_outcome, {
    
    factorinterest <- input$selection_outcome$right
    choices <-  unique(datainput()[,factorinterest])  
    updateSelectInput(session = getDefaultReactiveDomain(), inputId = "reference_outcome", choices = choices) 
    })
  
  referencename_outcome <- reactive({
    
    req(input$reference_outcome)
    input$reference_outcome
    
    })
  
  # Stop if column names not distinct or if too many columns selected
  
  observe({
    
    req(input$file, datainput())
    removeModal()
    
    if (length(input$selection_outcome$right) > 1 ){
      showNotification("Please select only one outcome variable.", duration=30)
      Sys.sleep(5)
      #session$close() Temporaer auskommentiert zu Testzwecken
      }
    
    if (length(input$selection_exposure$right) > 1 ){
      showNotification("Please select only one exposure variable.", duration=30)
      Sys.sleep(5)
      #session$close() Temporaer auskommentiert zu Testzwecken
      }
    })
  
  # This creates a short-term storage location for a filepath 
  report <- reactiveValues(filepath = NULL) 
  
  # Render report
  observeEvent(input$generate, once=T,
               ignoreInit=T,{
                 
                 req(input$file, datainput(), input$selection_outcome$right)
                 
                 src1 <- normalizePath('report_html.Rmd')
                 src2 <- normalizePath('references.bib')
                 src5 <- normalizePath('FiraSans-Bold.otf')
                 src6 <- normalizePath('FiraSans-Regular.otf')
                 
                 # Temporarily switch to the temp dir
                 owd <- setwd(tempdir())
                 on.exit(setwd(owd))
                 file.copy(src1, 'report_html.Rmd', overwrite = TRUE)
                 file.copy(src2, 'references.bib', overwrite = TRUE)
                 file.copy(src5, 'FiraSans-Bold.otf', overwrite = TRUE)
                 file.copy(src6, 'FiraSans-Regular.otf', overwrite = TRUE)
                 
                 # Set up parameters to pass to Rmd document
                 enc_guessed <- guess_encoding(input$file$datapath)
                 enc_guessed_first <- enc_guessed[[1]][1]
                 
                 params <- list(data = datainput(), 
                                filename=input$file, 
                                #fencoding=input$fencoding, # Temporaer auskommentiert
                                #decimal=input$decimal, # Temporaer auskommentiert
                                enc_guessed = enc_guessed_first, 
                                outcome = input$selection_outcome$right, 
                                exposure = input$selection_exposure$right, 
                                presence_outcome = referencename_outcome(),
                                presence_exposure = referencename_exposure(), 
                                a1 = input$a1, 
                                b1 = input$b1, 
                                a2 = input$a2, 
                                b2 = input$b2,
                                user_selection_function_param = 1) 
                 
                 tryCatch({
                   
                   withProgress(message = 'Please wait, the Statsomat app is computing. This may take a while.', value=0, {
                     
                     for (i in 1:15) {
                       incProgress(1/15)
                       Sys.sleep(0.25)
                       }
                     
                     if (input$rcode == "Data Analysis Report (HTML)"){
                       
                       tmp_file <- render('report_html.Rmd', html_document(),
                                          params = params,
                                          envir = new.env(parent = globalenv())
                                          )
                       } else {
                         
                         tmp_file <- render('report_html.Rmd', html_document(),
                                            params = params,
                                            envir = new.env(parent = globalenv())
                         )
                         }
                     
                     report$filepath <- tmp_file 
                     })
                   
                   showNotification("Now you can download the file.", duration=20)
                   
                   },
                   
                   error=function(e) {
                     
                     # Report not available 
                     showNotification("Something went wrong. Please contact the support@statsomat.com. ",duration=20)
                     
                     }
                   )
                 })
  
  # Enable downloadbutton 
  observe({
    req(!is.null(report$filepath))
    session$sendCustomMessage("check_generation", list(check_generation  = 1))
    })
  
  # Download report
  output$download <- downloadHandler(
    filename = function() {
      if (input$rcode == "Data Analysis Report (HTML)"){
        paste('MyReport',sep = '.','html')
        } else {
          paste('MyCode',sep = '.','html')
          }
      },
    
    content = function(file) {
      
      file.copy(report$filepath, file)
      
      }
    )
}