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
