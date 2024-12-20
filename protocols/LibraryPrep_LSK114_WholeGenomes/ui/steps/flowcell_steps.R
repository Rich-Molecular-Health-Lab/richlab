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

flowcell.recs <- accordion_panel(
  "Recommendations", 
    card(class = "bg-warning",
         card_header("IMPORTANT"),
         card_body("Please note, this kit is only compatible with R10.4.1 flow cells (FLO-MIN114).")),
    card(class = "bg-warning",
         card_header("IMPORTANT"),
         card_body("For optimal sequencing performance and improved output on MinION R10.4.1 flow cells (FLO-MIN114), ONT recommends adding Bovine Serum Albumin (BSA) to the flow cell priming mix at a final concentration of 0.2 mg/ml."),
         card_footer("ONT does not recommend using any other albumin type (e.g. recombinant human serum albumin)."))
)