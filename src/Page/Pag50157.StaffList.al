page 50157 "Staff List"
{
    ApplicationArea = All;
    Caption = 'Staff List';
    PageType = List;
    SourceTable = Staff;
    CardPageId = "Staff Card";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Staff No"; Rec."Staff No")
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
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
