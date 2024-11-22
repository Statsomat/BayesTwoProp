
# Define server logic 
server_table <- function(input, output, session) {
  
  # Reload app if disconnected
  observeEvent(input$disconnect, {
    session$close()
    })
  
  # Reload app button
  observeEvent(input$reload,session$reload())
  
  # On session end
  session$onSessionEnded(stopApp)
  
  report <- reactiveValues(filepath = NULL) 
  
  # Render report
  observeEvent(input$generate, once=TRUE,
               ignoreInit=TRUE,{
                 
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
                 params <- list(exposurename = input$name_Exposure, 
                                outcomename = input$name_Outcome,
                                a1 = 1/2, 
                                b1 = 1/2, 
                                a2 = 1/2, 
                                b2 = 1/2,
                                user_selection_function_param = 1,
                                s1 = input$sample[2,2], 
                                s2 = input$sample[2,1], 
                                n1 = (input$sample[2,2]+input$sample[1,2]),
                                n2 = (input$sample[2,1]+input$sample[1,1]))
                 
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