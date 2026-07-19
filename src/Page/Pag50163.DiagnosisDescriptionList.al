page 50163 "Diagnosis Description List"
{
    ApplicationArea = All;
    Caption = 'Diagnosis Description List';
    PageType = List;
    SourceTable = "Diagnosis Description";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    var
                        HMSSetup: Record "HMS Setup";
                        NoSeriesMgt: Codeunit NoSeriesManagement;
                        NoSeriesCode: Code[20];
                    begin
                        HMSSetup.Get();
                        if NoSeriesMgt.SelectSeries(HMSSetup."Diagnosis Description Nos", Rec."No. Series", NoSeriesCode) then begin
                            Rec.Validate("No. Series", NoSeriesCode);
                            Rec.Validate(Code, NoSeriesMgt.GetNextNo(NoSeriesCode, WorkDate(), false));
                            CurrPage.Update();
                        end;
                    end;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("G/L Account No"; Rec."G/L Account No")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
