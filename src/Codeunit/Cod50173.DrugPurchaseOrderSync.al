codeunit 50173 "Drug Purchase Order Sync"
{
    procedure Run(Drug: Record Drug)
    var
        PurchHeader: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
    begin
        Drug.TestField("Item No");
        Drug.TestField("Vendor No");

        PurchHeader.Init();
        PurchHeader."Document Type" := PurchHeader."Document Type"::Order;
        PurchHeader.Insert(true);
        PurchHeader.Validate("Buy-from Vendor No.", Drug."Vendor No");
        PurchHeader.Modify(true);

        PurchLine.Init();
        PurchLine."Document Type" := PurchHeader."Document Type";
        PurchLine."Document No." := PurchHeader."No.";
        PurchLine."Line No." := 10000;
        PurchLine.Validate(Type, PurchLine.Type::Item);
        PurchLine.Validate("No.", Drug."Item No");
        PurchLine.Validate(Quantity, Drug."Reorder Quantity");
        PurchLine.Insert(true);
    end;
}
