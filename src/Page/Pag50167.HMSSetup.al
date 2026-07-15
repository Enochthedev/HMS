page 50167 "HMS Setup"
{
    ApplicationArea = All;
    Caption = 'HMS Setup';
    PageType = Card;
    SourceTable = "HMS Setup";
    InsertAllowed = false;
    DeleteAllowed = false;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Staff Nos"; Rec."Staff Nos")
                {
                    ApplicationArea = All;
                }
                field("Patient Nos"; Rec."Patient Nos")
                {
                    ApplicationArea = All;
                }
                field("Ward Nos"; Rec."Ward Nos")
                {
                    ApplicationArea = All;
                }
                field("Diagnosis Doc Nos"; Rec."Diagnosis Doc Nos")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}
