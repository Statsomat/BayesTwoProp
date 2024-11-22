
# Define server logic 
  
function(input, output, session) { 
  
  observeEvent(input$input_type, {
    
    if(input$input_type==1){
      
      server_file(input, output, session)
      
      } else {
        
        server_table(input, output, session)
      }
    }
    )
  }