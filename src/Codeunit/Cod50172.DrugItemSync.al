codeunit 50172 "Drug Item Sync"
{
    procedure Run(var Drug: Record Drug)
    var
        Item: Record Item;
        InventorySetup: Record "Inventory Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        IsNewItem: Boolean;
    begin
        IsNewItem := Drug."Item No" = '';
        if IsNewItem then begin
            InventorySetup.Get();
            InventorySetup.TestField("Item Nos.");
            Item.Init();
            Item."No." := NoSeriesMgt.GetNextNo(InventorySetup."Item Nos.", WorkDate(), true);
        end else
            Item.Get(Drug."Item No");

        Item.Description := Drug.Description;

        if IsNewItem then begin
            Item.Insert(true);
            Drug."Item No" := Item."No.";
            Drug.Modify(true);
        end else
            Item.Modify(true);
    end;
}
