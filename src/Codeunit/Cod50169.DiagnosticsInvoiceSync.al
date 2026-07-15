codeunit 50169 "Diagnostics Invoice Sync"
{
    procedure Run(var DiagnosticsHeader: Record "Diagnostics Header")
    var
        Patient: Record Patient;
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        DiagnosticsLine: Record "Diagnostics Line";
        DiagnosisDescription: Record "Diagnosis Description";
        Drug: Record Drug;
        LineNo: Integer;
    begin
        Patient.Get(DiagnosticsHeader."Patient No");
        Patient.TestField("Customer No");

        if DiagnosticsHeader."Invoice No" = '' then begin
            SalesHeader.Init();
            SalesHeader."Document Type" := SalesHeader."Document Type"::Invoice;
            SalesHeader.Insert(true);
            SalesHeader.Validate("Sell-to Customer No.", Patient."Customer No");
            SalesHeader.Modify(true);
            DiagnosticsHeader."Invoice No" := SalesHeader."No.";
            DiagnosticsHeader.Modify(true);
        end else
            SalesHeader.Get(SalesHeader."Document Type"::Invoice, DiagnosticsHeader."Invoice No");

        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        SalesLine.DeleteAll(true);

        DiagnosticsLine.SetRange("Document No", DiagnosticsHeader."Document No");
        if DiagnosticsLine.FindSet() then
            repeat
                LineNo += 10000;
                SalesLine.Init();
                SalesLine."Document Type" := SalesHeader."Document Type";
                SalesLine."Document No." := SalesHeader."No.";
                SalesLine."Line No." := LineNo;

                if DiagnosticsLine.Type = DiagnosticsLine.Type::Drug then begin
                    Drug.Get(DiagnosticsLine."Test No");
                    Drug.TestField("Item No");
                    SalesLine.Validate(Type, SalesLine.Type::Item);
                    SalesLine.Validate("No.", Drug."Item No");
                end else begin
                    DiagnosisDescription.Get(DiagnosticsLine."Test No");
                    DiagnosisDescription.TestField("G/L Account No");
                    SalesLine.Validate(Type, SalesLine.Type::"G/L Account");
                    SalesLine.Validate("No.", DiagnosisDescription."G/L Account No");
                end;

                SalesLine.Validate(Description, DiagnosticsLine.Description);
                SalesLine.Validate(Quantity, 1);
                SalesLine.Insert(true);
            until DiagnosticsLine.Next() = 0;
    end;
}
