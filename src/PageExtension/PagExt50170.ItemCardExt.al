pageextension 50170 "Item Card Ext" extends "Item Card"
{
    actions
    {
        addlast(Processing)
        {
            action(CreatePurchaseOrder)
            {
                ApplicationArea = All;
                Caption = 'Create Purchase Order';
                Image = OrderList;

                trigger OnAction()
                var
                    ItemPurchaseOrderSync: Codeunit "Item Purchase Order Sync";
                begin
                    ItemPurchaseOrderSync.Run(Rec);
                    Message('A purchase order has been created for %1.', Rec."No.");
                end;
            }
        }
    }
}
