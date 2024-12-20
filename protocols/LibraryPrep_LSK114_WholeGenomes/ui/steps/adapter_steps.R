adapter <- list(
  list("Spin down the Ligation Adapter (LA) and Salt-T4® DNA Ligase, and place on ice."),
  list("Thaw Ligation Buffer (LNB) at room temperature, spin down and mix by pipetting. Due to viscosity, vortexing this buffer is ineffective. Place on ice immediately after thawing and mixing."),
  list("Thaw the Elution Buffer (EB) at room temperature and mix by vortexing. Then spin down and place on ice."),
  list("Thaw either Long Fragment Buffer (LFB) or Short Fragment Buffer (SFB) at room temperature and mix by vortexing. Then spin down and place on ice."),
  list("In a 1.5 ml Eppendorf DNA LoBind tube, prepare the reaction mix shown below."),
  list("Thoroughly mix the reaction by gently pipetting and briefly spinning down."),
  list("Incubate the reaction for 10 minutes at room temperature.")) %>%
  set_names(paste0("II.", seq_along(.), "."))

adapter.recs <- accordion_panel(
  "Recommendations", 
     card(class = "bg-info",
          card_header("Tip from ONT"),
          card_body("ONT recommends using the  the Salt-T4® DNA Ligase (NEB, M0467)"),
          card_footer("Salt-T4® DNA Ligase (NEB, M0467) can be bought separately or is provided in the NEBNext® Companion Module v2 for Oxford Nanopore Technologies® Ligation Sequencing (E7672S/E7672L).", br(), "The Quick T4 DNA Ligase (NEB, E6057) available in the previous version NEBNext® Companion Module for Oxford Nanopore Technologies® Ligation Sequencing (NEB, E7180S/E7180L) is also compatible, but the new recommended reagent offers more efficient and ligation.")),
     card(class = "bg-warning",
          card_header("IMPORTANT"),
          card_body("Although third-party ligase products may be supplied with their own buffer, the ligation efficiency of the Ligation Adapter (LA) is higher when using the Ligation Buffer (LNB) supplied in the Ligation Sequencing Kit.")),
     card(class = "bg-warning",
          card_header("IMPORTANT"),
          card_body("Depending on the wash buffer (LFB or SFB) used, the clean-up step after adapter ligation is designed to either enrich for DNA fragments of >3 kb, or purify all fragments equally."),
          card_footer(
            tags$ul(
              tags$li("To enrich for DNA fragments of 3 kb or longer, use Long Fragment Buffer (LFB)"),
              tags$li("To retain DNA fragments of all sizes, use Short Fragment Buffer (SFB)")))))