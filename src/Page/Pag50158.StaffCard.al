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
                field("Employee No"; Rec."Employee No")
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
            action(CreateUpdateEmployee)
            {
                ApplicationArea = All;
                Caption = 'Create/Update Employee';
                Image = Employee;
                trigger OnAction()
                var
                    StaffEmployeeSync: Codeunit "Staff Employee Sync";
                begin
                    StaffEmployeeSync.Run(Rec);
                    CurrPage.Update(false);
                    Message('Employee %1 has been created/updated.', Rec."Employee No");
                end;
            }
        }
    }
}
