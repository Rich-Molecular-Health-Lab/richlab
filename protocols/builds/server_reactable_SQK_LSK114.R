
output$samples <- renderReactable({
  reactable(samples.loris, 
            groupBy             = c("SampleID"),
            details             = seq_subtable,
            columns             = columns,
            columnGroups        = column_groups,
            theme               = format_select,
            selection           = "multiple", 
            defaultExpanded     = TRUE,
            onClick             = "select",
            filterable          = TRUE, 
            paginationType      = "simple", 
            showPageSizeOptions = TRUE, 
            highlight           = TRUE, 
            compact             = TRUE, 
            showSortable        = TRUE, 
            defaultPageSize     = 20,
            height              = "auto")
})

output$filtered_table <- renderReactable({
  req(selected_samples())
    reactable(
      selected_samples(),
      columns = list(
        TubeNo             = colDef(name = "Tube Number")                                                 ,  
        ExtractID_DNA      = colDef(name = "Extract ID")                                                  ,  
        ExtractConc_DNA    = colDef(name = "Extract Concentration"  , format = colFormat(suffix = ngul))  ,  
        ExtractInputVol    = colDef(name = "Extract to Add"         , format = colFormat(suffix = ul))    ,
        ExtractDiluteWater = colDef(name = "Water to Add"           , format = colFormat(suffix = ul))    ,
        SampleID           = colDef(show = FALSE)                                                         ,  
        InputMassStart     = colDef(name = "Mass to Add"            , format = colFormat(suffix = " ng")) ,
        LibPrepBy          = colDef(name = "Library Prep By")                                             ,
        LibPrepDate        = colDef(name = "Library Prep Date"      , format = colFormat(date = TRUE))    ,                 
        FlowCellType       = colDef(show = FALSE)                                                         , 
        FlowCellSerial     = colDef(show = FALSE)                                                         ,   
        SeqDevice          = colDef(show = FALSE)                                                         ,
        AdjLength          = colDef(show = FALSE)                                                         ,
        Strands            = colDef(show = FALSE)                                                         ,   
        InputMassFinal     = colDef(show = FALSE)                                                         ,                                                                                
        .selection         = colDef(name = "Check when added", sticky = "left")                           ),
      paginationType      = "simple", 
      highlight           = TRUE, 
      compact             = TRUE, 
      defaultPageSize     = 10,
      height              = "auto"
    )
})



output$extracts_endprep <- renderReactable({
  req(selected_samples())
  reactable(selected_samples(),
            columns = 
              list(
                TubeNo                 = colDef(name = "Tube Number")                                                 ,  
                ExtractID_DNA          = colDef(name = "Extract ID")                                                  ,  
                ExtractConc_DNA        = colDef(name = "Extract Concentration"  , format = colFormat(suffix = ngul))  ,  
                ExtractInputVol        = colDef(name = "Extract to Add"         , format = colFormat(suffix = ul))    ,
                ExtractDiluteWater     = colDef(name = "Water to Add"           , format = colFormat(suffix = ul))    ,
                SampleID               = colDef(show = FALSE)                                                         ,  
                InputMassStart         = colDef(show = FALSE)                                                         ,   
                LibPrepBy              = colDef(show = FALSE)                                                         , 
                LibPrepDate            = colDef(show = FALSE)                                                         ,  
                FlowCellType           = colDef(show = FALSE)                                                         , 
                FlowCellSerial         = colDef(show = FALSE)                                                         ,   
                SeqDevice              = colDef(show = FALSE)                                                         ,
                AdjLength              = colDef(show = FALSE)                                                         ,
                Strands                = colDef(show = FALSE)                                                         ,   
                InputMassFinal         = colDef(show = FALSE)                                                         ,                                                                                
                .selection             = colDef(name = "Check when added", sticky = "left")                           ),
            paginationType      = "simple", 
            selection           = "multiple",
            onClick             = "select",
            theme               = format_checklist,
            highlight           = TRUE, 
            compact             = TRUE, 
            defaultPageSize     = 10,
            height              = "auto")
})

output$endprep_react <- renderReactable({
  reactable(endprep_rxn(),
            columns = list(
              Reagent      = colDef(name = "Reagent"),
              Volume_pRxn  = colDef(name = "Volume per Rxn", format = colFormat(suffix = ul)),
              Total_Volume = colDef(name = "Total Volume"  , format = colFormat(suffix = ul)),
              .selection   = colDef(name =  "Check when added", sticky = "left")
            ),
            paginationType      = "simple", 
            selection           = "multiple",
            onClick             = "select",
            theme               = format_checklist,
            highlight           = TRUE, 
            compact             = TRUE, 
            defaultPageSize     = 10,
            height              = "auto")
})

output$final_libraries <- renderReactable({
  req(working_samples())
  reactable(working_samples(),
              columns             = list(
                TubeNo                 = colDef(name = "Tube Number")                                                 ,  
                ExtractID_DNA          = colDef(name = "Extract ID")                                                  ,  
                ExtractConc_DNA        = colDef(show = FALSE)                                                         ,  
                ExtractInputVol        = colDef(show = FALSE)                                                         ,
                ExtractDiluteWater     = colDef(show = FALSE)                                                         ,
                AdjustLibrary          = colDef(name = "Adjust Library Concentration?")                               ,  
                LibraryLoadingVol      = colDef(name = "Library Vol to Add"     , format = colFormat(suffix = ul))    ,  
                LibraryWaterVol        = colDef(name = "Water to Add"           , format = colFormat(suffix = ul))    ,
                Conc_QC1               = colDef(name = "QC1 Concentration"      , format = colFormat(suffix = ngul))  ,  
                Conc_QC2               = colDef(name = "Final Concentration"    , format = colFormat(suffix = ngul))  ,  
                SampleID               = colDef(show = FALSE)                                                         ,  
                InputMassStart         = colDef(show = FALSE)                                                         ,   
                LibPrepBy              = colDef(show = FALSE)                                                         , 
                LibPrepDate            = colDef(show = FALSE)                                                         ,  
                FlowCellType           = colDef(show = FALSE)                                                         , 
                FlowCellSerial         = colDef(show = FALSE)                                                         ,   
                SeqDevice              = colDef(show = FALSE)                                                         ,
                AdjLength              = colDef(show = FALSE)                                                         ,
                Strands                = colDef(show = FALSE)                                                         ,   
                InputMassFinal         = colDef(show = FALSE)                                                         ,                                                                                
                .selection             = colDef(name = "Check when added", sticky = "left")                           ),
            paginationType      = "simple", 
            selection           = "multiple",
            onClick             = "select",
            theme               = format_checklist,
            highlight           = TRUE, 
            compact             = TRUE, 
            defaultPageSize     = 10,
            height              = "auto")
})


