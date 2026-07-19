codeunit 50174 "Ward Sales Order Sync"
{
    procedure Run(Ward: Record Ward)
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
    begin
        Ward.TestField("G/L Account No");
        Ward.TestField("Order Quantity");

        SalesHeader.Init();
        SalesHeader."Document Type" := SalesHeader."Document Type"::Order;
        SalesHeader.Insert(true);

        SalesLine.Init();
        SalesLine."Document Type" := SalesHeader."Document Type";
        SalesLine."Document No." := SalesHeader."No.";
        SalesLine."Line No." := 10000;
        SalesLine.Validate(Type, SalesLine.Type::"G/L Account");
        SalesLine.Validate("No.", Ward."G/L Account No");
        SalesLine.Validate(Description, StrSubstNo('Ward stay - %1', Ward.Description));
        SalesLine.Validate(Quantity, Ward."Order Quantity");
        SalesLine.Insert(true);
    end;
}
