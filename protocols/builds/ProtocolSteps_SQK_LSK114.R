endprep <- list(
  list("Thaw DNA Control Sample (DCS) at room temperature, spin down, mix by pipetting, and place on ice."),
  list("Prepare the NEB reagents in accordance with manufacturer’s instructions, and place on ice.",
       a = "Thaw all reagents on ice.",
       b = "Flick and/or invert the reagent tubes to ensure they are well mixed. Do not vortex the FFPE DNA Repair Mix or Ultra II End Prep Enzyme Mix.",
       c = "Always spin down tubes before opening for the first time each day.",
       d = "Vortex the FFPE DNA Repair Buffer v2, or the NEBNext FFPE DNA Repair Buffer and Ultra II End Prep Reaction Buffer to ensure they are well mixed.",
       e = "The FFPE DNA Repair Buffer may have a yellow tinge and is fine to use if yellow."),
  list("Prepare the DNA in nuclease-free water according to the values in the table below.",
       a = "Transfer the 'Extract to add' volume into a 1.5 ml Eppendorf DNA LoBind tube.",
       b = "Add nuclease-free water according to the volume under 'H2O to add' to reach the total volume.",
       c = "Check each row as you go to keep track of progress.",
       d = "Mix thoroughly by pipetting up and down, or by flicking the tube.",
       e = "Spin down briefly in a microfuge."),
  list("In a 0.2 ml thin-walled PCR tube, prepare the reaction mix."),
  list("Thoroughly mix the reaction by gently pipetting and briefly spinning down."),
  list("Using a thermal cycler, incubate at 20°C for 5 minutes and 65°C for 5 minutes."),
  list("Resuspend the AMPure XP Beads (AXP) by vortexing."),
  list("Transfer the DNA sample to a clean 1.5 ml Eppendorf DNA LoBind tube."),
  list("Add 60 µl of resuspended the AMPure XP Beads (AXP) to the end-prep reaction and mix by flicking the tube."),
  list("Incubate on a Hula mixer (rotator mixer) for 5 minutes at room temperature."),
  list("Prepare 500 μl of fresh 80% ethanol in nuclease-free water."),
  list("Spin down the sample and pellet on a magnet until supernatant is clear and colourless. Keep the tube on the magnet, and pipette off the supernatant."),
  list("Keep the tube on the magnet and wash the beads with 200 µl of freshly prepared 80% ethanol without disturbing the pellet. Remove the ethanol using a pipette and discard."),
  list("Repeat the previous step."),
  list("Spin down and place the tube back on the magnet. Pipette off any residual ethanol. Allow to dry for ~30 seconds, but do not dry the pellet to the point of cracking."),
  list("Remove the tube from the magnetic rack and resuspend the pellet in 61 µl nuclease-free water. Incubate for 2 minutes at room temperature."),
  list("Pellet the beads on a magnet until the eluate is clear and colourless, for at least 1 minute."),
  list("Remove and retain 61 µl of eluate into a clean 1.5 ml Eppendorf DNA LoBind tube."),
  list("Quantify 1 µl of eluted sample using a Qubit fluorometer. Enter the QC results for each library below before proceeding.")) %>%
  set_names(paste0("I.", seq_along(.), "."))

adapter <- list(
  list("Spin down the Ligation Adapter (LA) and Salt-T4® DNA Ligase, and place on ice."),
  list("Thaw Ligation Buffer (LNB) at room temperature, spin down and mix by pipetting. Due to viscosity, vortexing this buffer is ineffective. Place on ice immediately after thawing and mixing."),
  list("Thaw the Elution Buffer (EB) at room temperature and mix by vortexing. Then spin down and place on ice."),
  list("Thaw either Long Fragment Buffer (LFB) or Short Fragment Buffer (SFB) at room temperature and mix by vortexing. Then spin down and place on ice."),
  list("In a 1.5 ml Eppendorf DNA LoBind tube, prepare the reaction mix shown below."),
  list("Thoroughly mix the reaction by gently pipetting and briefly spinning down."),
  list("Incubate the reaction for 10 minutes at room temperature.")) %>%
  set_names(paste0("II.", seq_along(.), "."))

cleanup <- list(
  list("Resuspend the AMPure XP Beads (AXP) by vortexing."),
  list("Add 40 µl of resuspended AMPure XP Beads (AXP) to the reaction and mix by flicking the tube."),
  list("Incubate on a Hula mixer (rotator mixer) for 5 minutes at room temperature."),
  list("Spin down the sample and pellet on a magnet. Keep the tube on the magnet, and pipette off the supernatant when clear and colourless."),
  list("Wash the beads by adding either 250 μl Long Fragment Buffer (LFB) or 250 μl Short Fragment Buffer (SFB). Flick the beads to resuspend, spin down, then return the tube to the magnetic rack and allow the beads to pellet. Remove the supernatant using a pipette and discard."),
  list("Repeat the previous step."),
  list("Spin down and place the tube back on the magnet. Pipette off any residual supernatant. Allow to dry for ~30 seconds, but do not dry the pellet to the point of cracking."),
  list("Remove the tube from the magnetic rack and resuspend the pellet in 15 µl Elution Buffer (EB). Spin down and incubate for 10 minutes at room temperature. For high molecular weight DNA, incubating at 37°C can improve the recovery of long fragments."),
  list("Pellet the beads on a magnet until the eluate is clear and colourless, for at least 1 minute."),
  list("Remove and retain 15 µl of eluate containing the DNA library into a clean 1.5 ml Eppendorf DNA LoBind tube. Dispose of the pelleted beads"),
  list("Quantify 1 µl of eluted sample using a Qubit fluorometer. Enter the QC results for each library below before proceeding."),
  list("Prepare your final library in 12 µl of Elution Buffer (EB) according to the table below.")) %>%
  set_names(paste0("III.", seq_along(.), "."))

flowcell <- list(
  list("Thaw the Sequencing Buffer (SB), Library Beads (LIB) or Library Solution (LIS, if using), Flow Cell Tether (FCT) and Flow Cell Flush (FCF) at room temperature before mixing by vortexing. Then spin down and store on ice."),
  list("To prepare the flow cell priming mix with BSA, combine Flow Cell Flush (FCF) and Flow Cell Tether (FCT), as directed below. Mix by pipetting at room temperature."),
  list("Open the MinION or GridION device lid and slide the flow cell under the clip. Press down firmly on the flow cell to ensure correct thermal and electrical contact."),
  list("Slide the flow cell priming port cover clockwise to open the priming port."),
  list("After opening the priming port, check for a small air bubble under the cover. Draw back a small volume to remove any bubbles.",
       a = "Set a P1000 pipette to 200 µl",
       b = "Insert the tip into the priming port",
       c = "Turn the wheel until the dial shows 220-230 µl, to draw back 20-30 µl, or until you can see a small volume of buffer entering the pipette tip"),
  list("Load 800 µl of the priming mix into the flow cell via the priming port, avoiding the introduction of air bubbles. Wait for five minutes. During this time, prepare the library for loading by following the steps below."),
  list("Thoroughly mix the contents of the Library Beads (LIB) by pipetting."),
  list("In a new 1.5 ml Eppendorf DNA LoBind tube, prepare the flow cell reaction mix."),
  list("Complete the flow cell priming.",
       a = "Gently lift the SpotON sample port cover to make the SpotON sample port accessible.",
       b = "Load 200 µl of the priming mix into the flow cell priming port (not the SpotON sample port), avoiding the introduction of air bubbles."),
  list("Mix the prepared library gently by pipetting up and down just prior to loading."),
  list("Add 75 μl of the prepared library to the flow cell via the SpotON sample port in a dropwise fashion. Ensure each drop flows into the port before adding the next."),
  list("Gently replace the SpotON sample port cover, making sure the bung enters the SpotON port and close the priming port."),
  list("Place the light shield onto the flow cell.",
       a = "Carefully place the leading edge of the light shield against the clip. Note: Do not force the light shield underneath the clip.",
       b = "Gently lower the light shield onto the flow cell. The light shield should sit around the SpotON cover, covering the entire top section of the flow cell.")) %>%
  set_names(paste0("IV.", seq_along(.), "."))

steps <- c(adapter, cleanup, endprep, flowcell)

step_names <- names(steps)

endprep.recs <- accordion_panel("Recommendations", 
                          card(class = "bg-info",
                               card_header("ONT's QC Recommendation"),
                               card_body(tags$ul(
                                 tags$li("Samples with a wide distribution of fragment sizes, e.g. gDNA: Start with 1 μg of material for the Ligation Sequencing Kit, or 400 ng of material for the Rapid Sequencing Kit."),
                                 tags$li("Short fragment libraries, e.g. amplicons or cDNA: Start with 100-200 fmol."),
                                 tags$li("Some kits which have a PCR step included as part of the protocol can be used with lower DNA inputs: Refer to individual library prep protocols for details.")))),
                          card(class = "bg-info",
                               card_header("Tip from ONT"),
                               card_body("ONT recommends using the NEBNext® Companion Module v2 for Oxford Nanopore Technologies® Ligation Sequencing (E7672S/E7672L), which contains all the NEB reagents needed for use with the Ligation Sequencing Kit."),
                               card_footer("The previous version, NEBNext® Companion Module for Oxford Nanopore Technologies® Ligation Sequencing (NEB, E7180S/E7180L) is also compatible, but the recommended v2 module offers more efficient dA-tailing and ligation.")), 
                          card(class = "bg-info",
                               card_header("Tip from ONT"),
                               card_body("ONT recommends using the DNA Control Sample (DCS) in your library prep for troubleshooting purposes."),
                               card_footer("You can also omit this step and make up the extra 1 µl with your sample DNA, if preferred.")), 
                          card(class = "bg-primary",
                               card_header("Check your flow cell."),
                               card_body("You should perform a flow cell check before starting your library prep to ensure you have a flow cell with enough pores for a good sequencing run.",
                                         accordion(open = FALSE, accordion_panel(title = "Flow Cell Guidelines", gt_output("flowcell_check"))))))

adapter.recs <- accordion_panel("Recommendations", 
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

flowcell.recs <- accordion_panel("Recommendations", 
                                 card(class = "bg-warning",
                                     card_header("IMPORTANT"),
                                     card_body("Please note, this kit is only compatible with R10.4.1 flow cells (FLO-MIN114).")),
                                 card(class = "bg-warning",
                                      card_header("IMPORTANT"),
                                      card_body("For optimal sequencing performance and improved output on MinION R10.4.1 flow cells (FLO-MIN114), ONT recommends adding Bovine Serum Albumin (BSA) to the flow cell priming mix at a final concentration of 0.2 mg/ml."),
                                      card_footer("ONT does not recommend using any other albumin type (e.g. recombinant human serum albumin)."))
                                 )