page 50161 "Ward List"
{
    ApplicationArea = All;
    Caption = 'Ward List';
    PageType = List;
    SourceTable = Ward;
    CardPageId = "Ward Card";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Ward No"; Rec."Ward No")
                {
                    ApplicationArea = All;
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
            }
        }
    }
}
