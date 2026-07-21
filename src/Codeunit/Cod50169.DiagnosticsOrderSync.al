codeunit 50169 "Diagnostics Order Sync"
{
    procedure Run(var DiagnosticsHeader: Record "Diagnostics Header")
    var
        Patient: Record Patient;
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        DiagnosticsLine: Record "Diagnostics Line";
        IncompleteLine: Record "Diagnostics Line";
        DiagnosisDescription: Record "Diagnosis Description";
        Item: Record Item;
        Ward: Record Ward;
        PatientCustomerSync: Codeunit "Patient Customer Sync";
        NextSalesLineNo: Integer;
    begin
        if DiagnosticsHeader.Closed then
            Error('This document is closed. No further changes are allowed.');

        Patient.Get(DiagnosticsHeader."Patient No");
        if Patient."Customer No" = '' then
            PatientCustomerSync.Run(Patient);

        IncompleteLine.SetRange("Document No", DiagnosticsHeader."Document No");
        IncompleteLine.SetRange(Closed, false);
        IncompleteLine.SetFilter(Type, '<>%1', IncompleteLine.Type::" ");
        IncompleteLine.SetRange("Test No", '');
        if IncompleteLine.FindFirst() then
            Error('Line %1 has a Type but no Test No. Please complete or delete it before creating the order.', IncompleteLine."Line No");

        DiagnosticsLine.SetRange("Document No", DiagnosticsHeader."Document No");
        DiagnosticsLine.SetRange(Closed, false);
        DiagnosticsLine.SetFilter("Test No", '<>%1', '');
        if not DiagnosticsLine.FindSet() then
            Error('There are no new lines to add to an order.');

        if (DiagnosticsHeader."Order No" <> '') and not SalesHeader.Get(SalesHeader."Document Type"::Order, DiagnosticsHeader."Order No") then
            DiagnosticsHeader."Order No" := '';

        if DiagnosticsHeader."Order No" = '' then begin
            SalesHeader.Init();
            SalesHeader."Document Type" := SalesHeader."Document Type"::Order;
            SalesHeader.Insert(true);
            SalesHeader.Validate("Sell-to Customer No.", Patient."Customer No");
            SalesHeader.Modify(true);
            DiagnosticsHeader."Order No" := SalesHeader."No.";
            DiagnosticsHeader.Modify(true);
        end;

        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        if SalesLine.FindLast() then
            NextSalesLineNo := SalesLine."Line No.";

        repeat
            NextSalesLineNo += 10000;
            SalesLine.Init();
            SalesLine."Document Type" := SalesHeader."Document Type";
            SalesLine."Document No." := SalesHeader."No.";
            SalesLine."Line No." := NextSalesLineNo;

            case DiagnosticsLine.Type of
                DiagnosticsLine.Type::Drug:
                    begin
                        Item.Get(DiagnosticsLine."Test No");
                        SalesLine.Validate(Type, SalesLine.Type::Item);
                        SalesLine.Validate("No.", Item."No.");
                    end;
                DiagnosticsLine.Type::Admission:
                    begin
                        Ward.Get(DiagnosticsLine."Test No");
                        Ward.TestField("G/L Account No");
                        SalesLine.Validate(Type, SalesLine.Type::"G/L Account");
                        SalesLine.Validate("No.", Ward."G/L Account No");
                        SalesLine.Validate("Unit Price", Ward."Unit Price");
                    end;
                DiagnosticsLine.Type::Others:
                    begin
                        SalesLine.Validate(Type, SalesLine.Type::"G/L Account");
                        SalesLine.Validate("No.", DiagnosticsLine."Test No");
                    end;
                else begin
                    DiagnosisDescription.Get(DiagnosticsLine."Test No");
                    DiagnosisDescription.TestField("G/L Account No");
                    SalesLine.Validate(Type, SalesLine.Type::"G/L Account");
                    SalesLine.Validate("No.", DiagnosisDescription."G/L Account No");
                    SalesLine.Validate("Unit Price", DiagnosisDescription."Unit Price");
                end;
            end;

            SalesLine.Validate(Description, DiagnosticsLine.Description);
            SalesLine.Validate(Quantity, 1);
            SalesLine.Insert(true);

            DiagnosticsLine.Closed := true;
            DiagnosticsLine.Modify(true);
        until DiagnosticsLine.Next() = 0;
    end;
}
