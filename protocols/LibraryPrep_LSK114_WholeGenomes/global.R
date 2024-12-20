# global.R

# Load libraries
library(knitr)
library(BiocManager)
library(conflicted)
library(devtools)
library(dplyr)
library(fontawesome)
library(ggplot2)
library(ggpubr)
library(ggsci)
library(glue)
library(gt)
library(gtExtras)
library(gtable)
library(htmltools)
library(kableExtra)
library(knitcitations)
library(lubridate)
library(magrittr)
library(MASS)
library(paletteer)
library(pandoc)
library(png)
library(purrr)
library(rcompanion)
library(readr) 
library(RefManageR)
library(rlang)
library(rmarkdown)
library(shiny)
library(stringr)
library(tibble)
library(tidyr)
library(usethis)
library(utf8)
library(rmdformats)

library(lpSolve)
library(shinyMatrix)
library(akima)
library(showtext)
library(scales)
library(ggnewscale)
library(ggtext)
library(bslib)
library(bsicons)

library(pander)
library(flexdashboard)
library(shinydashboard)
library(sass)
library(shinyjs)
library(shinyTime)
library(reactable)

conflicts_prefer(dplyr::filter)
conflicts_prefer(dplyr::select)
conflicts_prefer(dplyr::left_join)
conflicts_prefer(dplyr::inner_join)
conflicts_prefer(dplyr::full_join)
conflicts_prefer(dplyr::semi_join)
conflicts_prefer(dplyr::rename)
conflicts_prefer(ggplot2::margin)
conflicts_prefer(ggplot2::theme_classic)
conflicts_prefer(ggplot2::ggplot)
conflicts_prefer(ggplot2::theme_minimal)
conflicts_prefer(ggplot2::aes)
conflicts_prefer(dplyr::lag)
conflicts_prefer(RefManageR::cite)
conflicts_prefer(shinydashboard::box)
conflicts_prefer(rlang::set_names)
conflicts_prefer(purrr::flatten)
conflicts_prefer(base::which.max)
conflicts_prefer(lubridate::month)
conflicts_prefer(lubridate::year)
conflicts_prefer(lubridate::day)
conflicts_prefer(base::as.data.frame)

font_add("fa-solid", paste0(params$local, "dependencies/fonts/Font Awesome 6 Free-Solid-900.otf"))
showtext_auto()

lab.members <- list(
  "Azadmanesh, Shayda"      = "Shayda Azadmanesh (SA)", 
  "Gill, Dedric"            = "Dedric Gill (DG)", 
  "Miller, Joel"            = "Joel Miller (JM)",
  "Raad, Thomas"            = "Thomas Raad (TR)",
  "Rich, Alicia"            = "Alicia Rich (AMR)",
  "Segura-Palacio, Trineca" = "Trineca Segura-Palacio (TSP)",
  "Stout, Anthony"          = "Anthony Stout (AS)",
  "Wagstaff, Cate"          = "Cate Wagstaff (CW)",
  "Other"                   = "Other",
  "NA"                      = "NA")

lab.samplesets <- list(
  "Omaha Zoo Pygmy Lorises",
  "UNO Marmosets",
  "North American Bats (direct)",
  "North American Bats (environmental)",
  "Cultured Microbes",
  "Omaha Zoo Diets",
  "North American Bat Diets (wild)",
  "Other"
)

input_options <- list(
  "Wide distribution of fragment sizes"         = 1,
  "Amplicons or very short fragments of < 1 kb" = 2,
  "Amplicons or short fragments of 1-5 kb"      = 3,
  "Medium fragments of 5-10 kb"                 = 4,
  "Fragments longer than 10 kb"                 = 5)