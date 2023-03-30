#Data available at https://github.com/AdrianSotoM
#Please, address all correspondence about this code to adrian.sotom@incmnsz.mx
#Running it takes a few minutes, I've set up a sound to let you know 
#when it's done in case you want to do something else while it runs.

#Working directory setup
setwd("C:/Users/adria/Dropbox/UIEM/LEAD/Proyectos/IsqMed")

#Packages setup
pacman::p_load(dplyr,tidyr,ggstatsplot,readxl,tableone,easystats,
               patchwork,MASS,see,qqplotr,bootStepAIC,performance,
               rpart,rpart.plot,gtools,broom,lmtest,visdat,report,
               parameters,ggcharts,conflicted,car,rattle,cvms,
               mlogit,MLmetrics,beepr,chatgpt,usethis)

#Solving duplicate functions conflicts
conflict_prefer("select","dplyr")
conflict_prefer("filter", "dplyr")

# Ensuring reproducibility of this script.
# Since "easystats" is currently not available in CRAN, if you don't have it,
# you'll need to install manually.
# install.packages("easystats", repos = "https://easystats.r-universe.dev")

# Now, confirm you have "pacman" installed. If you don't have "pacman" but want
# to install it, remove the # in the line below and press "Enter".
# install.packages("pacman") 

describe_data_df <- function(x) {
  res_1 <- paste0("data is a dataframe with ", ncol(x), " colums", ":")
  
  res_2 <- sapply(x, class)
  res_2 <- sapply(1:length(res_2), function(x) {
    paste0("- Column ", x, " is named '", names(res_2)[x], "' and is of class ", res_2[x], ".")
  })
  res_2 <- paste(res_2, collapse = "\n")
  res <- paste(res_1, res_2, sep = "\n")
  
  return(res)
}

gpt_do <- function(data, prompt) {
  
  Sys.setenv(OPENAI_VERBOSE = FALSE)
  Sys.setenv(OPENAI_MODEL = "text-davinci-003")
  Sys.setenv(OPENAI_TEMPERATURE = 0)
  
  if(!is.data.frame(data)) {
    stop("data is not a dataframe.")
  }
  
  gpt_prompt <- paste0(describe_data_df(data),
                       prompt,
                       "Put the result in an object called 'res'",
                       "Return only the code, do not comment or explain.",
                       sep = "\n")
  
  gpt_code <- chatgpt::ask_chatgpt(gpt_prompt)
  cat(gpt_code)
  
  eval(parse(text = gpt_code))
  return(res)
}

# Set your OpenAI API key here
Sys.setenv(OPENAI_API_KEY = " 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")

#Data upload
data <- read_excel("data.xlsx")

#Data structure
names <- names(data)

#Visualizing missing values distribution
missval <- vis_dat(data)
missval

f1 <- ggscatterstats(data,bhbmm,histo)
f1

###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
use_github(protocol="https",auth_token=Sys.getenv("GITHUB_PAT"))

data %>%
  gpt_do("give me a scatter plot of histo by bhbmm with a regression line
         in black, bold axis titles, no background grid and signifficance") 

