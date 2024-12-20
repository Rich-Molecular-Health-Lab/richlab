# Shiny App File Structure

## Root Directory
- `app.R`: Main app entry point.
- `global.R`: Shared global variables and libraries.

## Server Directory
- `server_main.R`: Core server logic.
- `make_steps.R`: Function for generating nested steps.
- `observers.R`: Shiny observers and reactive events.
...

## UI Directory
- `ui_main.R`: Main UI layout.
- `ui_tabs.R`: Tab definitions for the app.
...

## Resources
- `data.R`: Data loading and preprocessing.
- `gt_tables.R`: Building and styling gt tables.
- `images/`: Static images used in the app.

File Structure for this Script:

```
protocols/LibraryPrep_LSK114_WholeGenomes/
├── app.Rmd                     # Main Shiny app file
├── global.R                    # Load libraries and other global settings
├── README.md                   # App outline
├── server/
│   ├── helper_functions.R      # Reusable utility functions
│   ├── make_steps.R            # Function to make nested steps
│   ├── observers.R             # Observers and dynamic updates
│   ├── reactable_outputs.R     # Reactable rendering functions
│   ├── render_gt_outputs.R     # gt rendering functions
│   ├── render_images.R         # image rendering functions
│   ├── ui_cards.R              # Render reactive cards for UI
│   ├── ui_logic.R              # Render UI-specific server logic
├── ui/
│   ├── ui_tabs.R               # Definitions for tabs (Setup, End Prep, etc.)
│   ├── steps/                  # Compile protocol steps
│   │   ├── step_definitions.R  # Combining and naming steps across tabs
│   │   ├── endprep_steps.R     # Setting the list of steps for the endprep tab
│   │   ├── adapter_steps.R     # Setting the list of steps for the adapter tab
│   │   ├── cleanup_steps.R     # Setting the list of steps for the cleanup tab
│   │   ├── flowcell_steps.R    # Setting the list of steps for the flowcell tab
├── resources/
│   ├── assets_loader.R     # Rendering code for JS, html, and other formats
│   ├── data_gt.R           # Building gt tabls from dataframes/tibbles
│   ├── data_loader.R       # Loading dataframes and tibbles
│   ├── images/             # Image file attachments to render
│       ├── SQK-LSK114_bottle.svg
│       ├── SQK-LSK114_tubes.svg
│       ├── Flow_Cell_Loading_Diagrams_Step_1a.svg
│       ├── Flow_Cell_Loading_Diagrams_Step_1b.svg
│       ├── Flow_Cell_Loading_Diagrams_Step_2.svg
│       ├── Flow_Cell_Loading_Diagrams_Step_03_V5.gif
│       ├── Flow_Cell_Loading_Diagrams_Step_04_V5.gif
│       ├── Flow_Cell_Loading_Diagrams_Step_5.svg
│       ├── Flow_Cell_Loading_Diagrams_Step_06_V5.gif
│       ├── Flow_Cell_Loading_Diagrams_Step_07_V5.gif
│       ├── Flow_Cell_Loading_Diagrams_Step_9.svg
│       ├── Step_8_update.png
│       ├── J2264_-_Light_shield_animation_Flow_Cell_FAW_optimised.gif
```
