library(burro)
library(shiny)
library(here)
#set option so explore_data returns a list instead of a shinyApp()
#object
options(app_list=TRUE)

readmit_data <- readRDS(here('data','dataset.rds'))
  outcome_var <- 'readmit30'

data_dict <- NULL

data_dict_path <- here('data', 'data_dictionary.rds')
if(file.exists(data_dict_path)) {

    data_dict <- readRDS(data_dict_path)

}

#edit your covariates here
covars <- c('age','readmit30','length_of_stay','diabetes_complications','myocardial_complications','outcome','admit_source')

#build the burro app and run it
app_list <- burro::explore_data(dataset=readmit_data,
      covariates=covars,
      data_dictionary=data_dict)

ui <- app_list[['ui']]
server <- app_list[['server']]

app <- shiny::shinyApp(ui, server)
app
