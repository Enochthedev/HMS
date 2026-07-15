page 50169 "Drug Card"
{
    ApplicationArea = All;
    Caption = 'Drug Card';
    PageType = Card;
    SourceTable = Drug;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Item No"; Rec."Item No")
                {
                    ApplicationArea = All;
                }
                field("Vendor No"; Rec."Vendor No")
                {
                    ApplicationArea = All;
                }
                field("Reorder Quantity"; Rec."Reorder Quantity")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(CreateUpdateItem)
            {
                ApplicationArea = All;
                Caption = 'Create/Update Item';
                Image = Item;
                trigger OnAction()
                var
                    DrugItemSync: Codeunit "Drug Item Sync";
                begin
                    DrugItemSync.Run(Rec);
                    CurrPage.Update(false);
                    Message('Item %1 has been created/updated.', Rec."Item No");
                end;
            }
            action(CreatePurchaseOrder)
            {
                ApplicationArea = All;
                Caption = 'Create Purchase Order';
                Image = OrderList;
                trigger OnAction()
                var
                    DrugPurchaseOrderSync: Codeunit "Drug Purchase Order Sync";
                begin
                    DrugPurchaseOrderSync.Run(Rec);
                    Message('A purchase order has been created for %1.', Rec.Code);
                end;
            }
        }
    }
}
