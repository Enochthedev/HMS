page 50158 "Staff Card"
{
    ApplicationArea = All;
    Caption = 'Staff Card';
    PageType = Card;
    SourceTable = Staff;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Staff No"; Rec."Staff No")
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
                        if NoSeriesMgt.SelectSeries(HMSSetup."Staff Nos", Rec."No. Series", NoSeriesCode) then begin
                            Rec.Validate("No. Series", NoSeriesCode);
                            Rec.Validate("Staff No", NoSeriesMgt.GetNextNo(NoSeriesCode, WorkDate(), false));
                            CurrPage.Update();
                        end;
                    end;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Vendor No"; Rec."Vendor No")
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
            action(CreateUpdateVendor)
            {
                ApplicationArea = All;
                Caption = 'Create/Update Vendor';
                Image = Vendor;
                trigger OnAction()
                var
                    StaffVendorSync: Codeunit "Staff Vendor Sync";
                begin
                    StaffVendorSync.Run(Rec);
                    CurrPage.Update(false);
                    Message('Vendor %1 has been created/updated.', Rec."Vendor No");
                end;
            }
        }
    }
}
