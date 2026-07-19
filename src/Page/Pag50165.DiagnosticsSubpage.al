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
                }
                field("Test No"; Rec."Test No")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
