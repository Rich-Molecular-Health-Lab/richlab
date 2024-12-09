library(knitr)
source(paste0(params$local, "dependencies/options.R"))
library(ape)
library(bibtex)
library(BiocManager)
library(bookdown)
library(conflicted)
library(cowplot)
library(data.table)
library(dplyr)
library(fontawesome)
library(forcats)
library(ggplot2)
library(ggpubr)
library(ggraph)
library(ggrepel)
library(ggsci)
library(ggstance)
library(ggh4x)
library(ggtree)
library(gridExtra)
library(gt)
library(gtable)
library(gtExtras)
library(htmltools)
library(jsonlite)
library(kableExtra)
library(knitr)
library(knitcitations)
library(lmerTest)
library(lubridate)
library(magrittr)
library(mime)
library(monomvn)
library(paletteer)
library(pandoc)
library(pavian)
library(pheatmap)
library(phangorn)
library(philr)
library(phyloseq)
library(prettydoc)
library(pspline)
library(purrr)
library(RefManageR)
library(rcompanion)
library(rlang)
library(rmarkdown)
library(Rsamtools)
library(scales)
library(seqinr)
library(stringr)
library(tibble)
library(tidyr)
library(tidyverse)
library(tinytex)
library(utf8)
library(vegan)
library(viridisLite)
library(xfun)
library(xml2)
library(XML)
library(rmdformats)
source(paste0(params$local, "dependencies/functions_adaptive.R"))
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