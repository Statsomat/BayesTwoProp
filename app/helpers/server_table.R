
# Define server logic 
server_table <- function(input, output, session) {
  
  # Reload app if disconnected
  observeEvent(input$disconnect, {
    session$close()
  })
  
  # On session end
  session$onSessionEnded(stopApp)
  

    
      
      report <- reactiveValues(filepath = NULL) 
      # Render report
      observeEvent(input$generate, once=T,
                   ignoreInit=T,{
        
        req(input$sample)
        
        src1 <- normalizePath('report.Rmd')
        src2 <- normalizePath('references.bib')
        #  src3 <- normalizePath('report_code_container.Rmd') 
        #  src4 <- normalizePath('report_code.Rmd') 
        src5 <- normalizePath('FiraSans-Bold.otf')
        src6 <- normalizePath('FiraSans-Regular.otf')
        
        # Temporarily switch to the temp dir
        owd <- setwd(tempdir())
        on.exit(setwd(owd))
        file.copy(src1, 'report.Rmd', overwrite = TRUE)
        file.copy(src2, 'references.bib', overwrite = TRUE)
        # file.copy(src3, 'report_code_container.Rmd', overwrite = TRUE)
        # file.copy(src4, 'report_code.Rmd', overwrite = TRUE)
        file.copy(src5, 'FiraSans-Bold.otf', overwrite = TRUE)
        file.copy(src6, 'FiraSans-Regular.otf', overwrite = TRUE)
        
        # Set up parameters to pass to Rmd document
        #enc_guessed <- guess_encoding(input$file$datapath)
        #enc_guessed_first <- enc_guessed[[1]][1]
        
        params <- list(dataTableInput= input$sample, exposurename= input$name_Exposure, outcomename= input$name_Outcome)
        
        
        
        tryCatch({
          
          withProgress(message = 'Please wait, the Statsomat app is computing. This may take a while.', value=0, {

            for (i in 1:15) {
              incProgress(1/15)
              Sys.sleep(0.25)

            }

            if (input$rcode == "Data Analysis Report (PDF)"){

              tmp_file <- render('report.Rmd', pdf_document(latex_engine = "xelatex"),
                                 params = params,
                                 envir = new.env(parent = globalenv())
              )

            } else {

              tmp_file <- render('report_code_container.Rmd', html_document(),
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
          
          if (input$rcode == "Data Analysis Report (PDF)"){
            paste('MyReport',sep = '.','pdf')
          } else {
            paste('MyCode',sep = '.','html')
          }
        },
        
        content = function(file) {
          
          file.copy(report$filepath, file)
          
        }
      )
    
    

  
  
}