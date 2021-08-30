teacher_tip <- function(tip){

  content <- paste0(':::{#tip-text .tip}
**Instructor tip:**\n
  ',tip,'
:::')

  cat(content)

  #cat(paste0('<p style="color:#3f0000; background-color:#f5f5dc"> <b>Instructor tip!</b><br>', content, '</p>'))
}
