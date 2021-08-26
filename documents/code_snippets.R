# Styling of output tables 
knitr::kable(dataframe, col.names = "Names", linesep = '', longtable=T) %>%
  kable_styling(font_size = 8, position = "center", full_width = FALSE, latex_options = c("HOLD_position","repeat_header"))


# Titles in Output 