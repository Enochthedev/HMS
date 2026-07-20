page 50162 "Ward Card"
{
    ApplicationArea = All;
    Caption = 'Ward Card';
    PageType = Card;
    SourceTable = Ward;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Ward No"; Rec."Ward No")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;

                    trigger OnAssistEdit()
                    var
                        HMSSetup: Record "HMS Setup";
                        NoSeriesMgt: Codeunit NoSeriesManagement;
                        NoSeriesCode: Code[20];
                    begin
                        HMSSetup.Get();
                        if NoSeriesMgt.SelectSeries(HMSSetup."Ward Nos", Rec."No. Series", NoSeriesCode) then begin
                            Rec.Validate("No. Series", NoSeriesCode);
                            Rec.Validate("Ward No", NoSeriesMgt.GetNextNo(NoSeriesCode, WorkDate(), false));
                            CurrPage.Update();
                        end;
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                }
                field("Bed Allocation"; Rec."Bed Allocation")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("G/L Account No"; Rec."G/L Account No")
                {
                    ApplicationArea = All;
                }
                field("Order Quantity"; Rec."Order Quantity")
                {
                    ApplicationArea = All;
                }
                field("Unit Price"; Rec."Unit Price")
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
            action(CreateUpdateLocation)
            {
                ApplicationArea = All;
                Caption = 'Create/Update Location';
                Image = Warehouse;
                trigger OnAction()
                var
                    WardLocationSync: Codeunit "Ward Location Sync";
                begin
                    WardLocationSync.Run(Rec);
                    CurrPage.Update(false);
                    Message('Location %1 has been created/updated.', Rec."Location Code");
                end;
            }
            action(CreateSalesOrder)
            {
                ApplicationArea = All;
                Caption = 'Create Sales Order';
                Image = Order;
                trigger OnAction()
                var
                    WardSalesOrderSync: Codeunit "Ward Sales Order Sync";
                begin
                    WardSalesOrderSync.Run(Rec);
                    Message('A sales order has been created for %1.', Rec."Ward No");
                end;
            }
        }
    }
}
