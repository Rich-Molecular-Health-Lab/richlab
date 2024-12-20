# render_gt_outputs.R

render_supplies_all <- function(output) {
  output$supplies_all <- render_gt({gt_supplies})
}
render_supplies_endprep <- function(output) {
  output$supplies_endprep <- render_gt({supplies_endprep})
}
render_kit_contents <- function(output) {
  output$kit_contents <- render_gt({SQK.LSK114.contents})
}
render_supplies_adapter  <- function(output) {
  output$supplies_adapter  <- render_gt({supplies_adapter})
  }
render_supplies_cleanup  <- function(output) {
  output$supplies_cleanup  <- render_gt({supplies_cleanup})
  }
render_supplies_flowcell <- function(output) {
  output$supplies_flowcell <- render_gt({supplies_flowcell})
  }
render_input_dna         <- function(output) {
  output$input_dna         <- render_gt({input_dna})
  }
render_flowcell_check    <- function(output) {
  output$flowcell_check    <- render_gt({flowcell_check})
  }
render_rxn_endprep       <- function(output) {
  output$rxn_endprep       <- render_gt({rxn_endprep})
  }
render_rxn_adapter       <- function(output) {
  output$rxn_adapter       <- render_gt({rxn_adapter})
  }
render_rxn_flowcell      <- function(output) {
  output$rxn_flowcell      <- render_gt({rxn_flowcell})
  }
render_rxn_sequence      <- function(output) {
  output$rxn_sequence      <- render_gt({rxn_sequence})
  }

