codeunit 50173 "Item Purchase Order Sync"
{
    procedure Run(Item: Record Item)
    var
        PurchHeader: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
    begin
        Item.TestField("Vendor No.");
        Item.TestField("Reorder Quantity");

        PurchHeader.Init();
        PurchHeader."Document Type" := PurchHeader."Document Type"::Order;
        PurchHeader.Insert(true);
        PurchHeader.Validate("Buy-from Vendor No.", Item."Vendor No.");
        PurchHeader.Modify(true);

        PurchLine.Init();
        PurchLine."Document Type" := PurchHeader."Document Type";
        PurchLine."Document No." := PurchHeader."No.";
        PurchLine."Line No." := 10000;
        PurchLine.Validate(Type, PurchLine.Type::Item);
        PurchLine.Validate("No.", Item."No.");
        PurchLine.Validate(Quantity, Item."Reorder Quantity");
        PurchLine.Insert(true);
    end;
}
