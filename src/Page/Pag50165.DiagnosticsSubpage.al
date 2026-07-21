page 50165 "Diagnostics Subpage"
{
    Caption = 'Diagnostics Subpage';
    PageType = ListPart;
    SourceTable = "Diagnostics Line";
    AutoSplitKey = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No"; Rec."Line No")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    Editable = LineNotClosed;
                }
                field("Test No"; Rec."Test No")
                {
                    ApplicationArea = All;
                    Editable = LineNotClosed;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = LineNotClosed;
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        LineNotClosed := not Rec.Closed;
    end;

    var
        LineNotClosed: Boolean;
}
