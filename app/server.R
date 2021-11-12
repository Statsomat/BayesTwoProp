
# Define server logic 
# function(input, output, session) {
#   
#   # Reload app if disconnected
#   observeEvent(input$disconnect, {
#     session$close()
#   })
#   
#   # Reload app button
#   observeEvent(input$reload,session$reload())
#   
#   # On session end
#   session$onSessionEnded(stopApp)
#   
#   # Upload message
#   observeEvent(input$file, {
#     showModal(modalDialog(
#       title = "Reading Data", "Please Wait", 
#       footer = NULL,
#       fade = FALSE,
#       easyClose = TRUE
#     ))
#     
#     Sys.sleep(2)
#     
#   }, priority=100)
  
function(input, output, session) { 
  
observeEvent(input$input_type, {

  if(input$input_type==1){
    server_file(input, output, session)
  }else{
    server_table(input, output, session)
  }
    
  }
 )
  
  
  
}