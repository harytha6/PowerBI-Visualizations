let
    Source = Excel.Workbook(File.Contents("C:\Haritha\Files\Analysis_Invoices_Data\Round 2\Project details FDT savings YTD092022.xlsx"), null, true),
    #"Single Efforts_Sheet" = Source{[Item="Single Efforts",Kind="Sheet"]}[Data],
    #"Promoted Headers" = Table.PromoteHeaders(#"Single Efforts_Sheet", [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"Month", Int64.Type}, {"Projektnummer", Int64.Type}, {"Projekt Name (ZBBUCH)", type text}, {"Projekt Type", type text}, {"Customer#(lf)(ZBBUCH)", Int64.Type}, {"Customer Name", type text}, {"Industry", type text}, {"Industry Name", type text}, {"Segments#(lf)(manuell)", type text}, {"Phasennummer", type text}, {"Leistungserfassungsnummer", Int64.Type}, {"Statistik-Datum", type date}, {"Buchungsdatum", type date}, {"Übertragungskennzeichen", type text}, {"Übertragungsdatum", type date}, {"Kostenstelle", Int64.Type}, {"Firma", type text}, {"FDT/Extern", type text}, {"Gruppe", type text}, {"Leistungsart", type text}, {"Leistungsartbezeichnung", type text}, {"Auftragsmenge", type number}, {"Verkaufsmengeneinh.", type text}, {"Einzelpreis", type number}, {"Einzelpreis (2021)", type number}, {"Gesamtpreis", type number}, {"Gesamtpreis#(lf)(2021)", type number}, {"Saving", type number}, {"Belegwährung", type text}, {"Istkosten(ATD)", type number}}),
    #"Duplicated Column" = Table.DuplicateColumn(#"Changed Type", "Projekt Name (ZBBUCH)", "Projekt Name (ZBBUCH) - Copy"),
    #"Renamed Columns" = Table.RenameColumns(#"Duplicated Column",{{"Projekt Name (ZBBUCH) - Copy", "Type of Project"}}),
    #"Reordered Columns" = Table.ReorderColumns(#"Renamed Columns",{"Month", "Projektnummer", "Projekt Name (ZBBUCH)", "Projekt Type", "Customer#(lf)(ZBBUCH)", "Customer Name", "Industry", "Industry Name", "Segments#(lf)(manuell)", "Phasennummer", "Leistungserfassungsnummer", "Statistik-Datum", "Buchungsdatum", "Übertragungskennzeichen", "Übertragungsdatum", "Kostenstelle", "Firma", "FDT/Extern", "Gruppe", "Leistungsart", "Leistungsartbezeichnung", "Auftragsmenge", "Verkaufsmengeneinh.", "Belegwährung", "Einzelpreis", "Einzelpreis (2021)", "Gesamtpreis", "Gesamtpreis#(lf)(2021)", "Saving", "Istkosten(ATD)", "Type of Project"}),
    #"Added Custom" = Table.AddColumn(#"Reordered Columns", "Custom", each Text.Contains([Type of Project], "Support",Comparer.OrdinalIgnoreCase )),
    #"Changed Type1" = Table.TransformColumnTypes(#"Added Custom",{{"Custom", type text}}),
    #"Replaced Value" = Table.ReplaceValue(#"Changed Type1","true","1",Replacer.ReplaceText,{"Custom"}),
    #"Replaced Value1" = Table.ReplaceValue(#"Replaced Value","false","0",Replacer.ReplaceText,{"Custom"}),
    #"Changed Type2" = Table.TransformColumnTypes(#"Replaced Value1",{{"Custom", Int64.Type}}),
    #"Renamed Columns1" = Table.RenameColumns(#"Changed Type2",{{"Custom", "support"}}),
    Custom1 = Table.AddColumn(#"Renamed Columns1", "Custom", each Text.Contains([Type of Project], "ongoing",Comparer.OrdinalIgnoreCase )),
    #"Renamed Columns2" = Table.RenameColumns(Custom1,{{"Custom", "ongoing"}}),
    #"Changed Type3" = Table.TransformColumnTypes(#"Renamed Columns2",{{"ongoing", type text}}),
    #"Replaced Value2" = Table.ReplaceValue(#"Changed Type3","false","0",Replacer.ReplaceText,{"ongoing"}),
    #"Replaced Value3" = Table.ReplaceValue(#"Replaced Value2","true","2",Replacer.ReplaceText,{"ongoing"}),
    #"Removed Columns" = Table.RemoveColumns(#"Replaced Value3",{"ongoing"}),
    #"Removed Columns1" = Table.RemoveColumns(#"Removed Columns",{"Type of Project", "support"}),
    #"Duplicated Column1" = Table.DuplicateColumn(#"Removed Columns1", "Projekt Type", "Projekt Type - Copy"),
    #"Renamed Columns3" = Table.RenameColumns(#"Duplicated Column1",{{"Projekt Type - Copy", "Convenient Naming"}}),
    #"Duplicated Column2" = Table.DuplicateColumn(#"Renamed Columns3", "Month", "Month - Copy"),
    #"Reordered Columns1" = Table.ReorderColumns(#"Duplicated Column2",{"Month", "Month - Copy", "Projektnummer", "Projekt Name (ZBBUCH)", "Projekt Type", "Customer#(lf)(ZBBUCH)", "Customer Name", "Industry", "Industry Name", "Segments#(lf)(manuell)", "Phasennummer", "Leistungserfassungsnummer", "Statistik-Datum", "Buchungsdatum", "Übertragungskennzeichen", "Übertragungsdatum", "Kostenstelle", "Firma", "FDT/Extern", "Gruppe", "Leistungsart", "Leistungsartbezeichnung", "Auftragsmenge", "Verkaufsmengeneinh.", "Belegwährung", "Einzelpreis", "Einzelpreis (2021)", "Gesamtpreis", "Gesamtpreis#(lf)(2021)", "Saving", "Istkosten(ATD)", "Convenient Naming"}),
    #"Replaced Value4" = Table.ReplaceValue(#"Reordered Columns1",1,2022,Replacer.ReplaceValue,{"Month - Copy"}),
    #"Replaced Value5" = Table.ReplaceValue(#"Replaced Value4",2,2022,Replacer.ReplaceValue,{"Month - Copy"}),
    #"Replaced Value6" = Table.ReplaceValue(#"Replaced Value5",3,2022,Replacer.ReplaceValue,{"Month - Copy"}),
    #"Replaced Value7" = Table.ReplaceValue(#"Replaced Value6",4,2022,Replacer.ReplaceValue,{"Month - Copy"}),
    #"Replaced Value8" = Table.ReplaceValue(#"Replaced Value7",5,2022,Replacer.ReplaceValue,{"Month - Copy"}),
    #"Replaced Value9" = Table.ReplaceValue(#"Replaced Value8",6,2022,Replacer.ReplaceValue,{"Month - Copy"}),
    #"Replaced Value10" = Table.ReplaceValue(#"Replaced Value9",7,2022,Replacer.ReplaceValue,{"Month - Copy"}),
    #"Replaced Value11" = Table.ReplaceValue(#"Replaced Value10",8,2022,Replacer.ReplaceValue,{"Month - Copy"}),
    #"Replaced Value12" = Table.ReplaceValue(#"Replaced Value11",9,2022,Replacer.ReplaceValue,{"Month - Copy"}),
    #"Filtered Rows" = Table.SelectRows(#"Replaced Value12", each [Month] <> null and [Month] <> ""),
    #"Merged Columns" = Table.CombineColumns(Table.TransformColumnTypes(#"Filtered Rows", {{"Month", type text}, {"Month - Copy", type text}}, "en-US"),{"Month", "Month - Copy"},Combiner.CombineTextByDelimiter("-", QuoteStyle.None),"Merged"),
    #"Changed Type4" = Table.TransformColumnTypes(#"Merged Columns",{{"Merged", type date}}),
    #"Added Custom1" = Table.AddColumn(#"Changed Type4", "Savings Check", each [#"Gesamtpreis#(lf)(2021)"]-[Gesamtpreis]),
    #"Renamed Columns4" = Table.RenameColumns(#"Added Custom1",{{"Merged", "Date"}, {"Auftragsmenge", "Billed Hours"}, {"Gesamtpreis", "Total Price"}, {"Kostenstelle", "Cost Center"}, {"Leistungsartbezeichnung", "Type of Service"}, {"Gesamtpreis#(lf)(2021)", "Total Price(2021)"}}),
    #"Changed Type5" = Table.TransformColumnTypes(#"Renamed Columns4",{{"Customer#(lf)(ZBBUCH)", type text}, {"Projektnummer", type text}, {"Project category", type text}, {"Country", type text}, {"Cost Center", type text}}),
    #"Renamed Columns5" = Table.RenameColumns(#"Changed Type5",{{"Einzelpreis", "Hourly Rate"}, {"Einzelpreis (2021)", "Hourly Rate (2021)"}, {"Total Price", "Total Price(2022)"}, {"Capex/Opex threshold", "Classification"}})
in
    #"Renamed Columns5"
