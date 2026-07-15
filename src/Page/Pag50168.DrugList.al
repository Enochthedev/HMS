page 50168 "Drug List"
{
    ApplicationArea = All;
    Caption = 'Drug List';
    PageType = List;
    SourceTable = Drug;
    CardPageId = "Drug Card";
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
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
