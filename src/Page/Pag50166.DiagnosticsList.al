page 50166 "Diagnostics List"
{
    ApplicationArea = All;
    Caption = 'Diagnostics List';
    PageType = List;
    SourceTable = "Diagnostics Header";
    CardPageId = "Diagnostics Document";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = All;
                }
                field("Patient No"; Rec."Patient No")
                {
                    ApplicationArea = All;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                }
                field(Doctor; Rec.Doctor)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
