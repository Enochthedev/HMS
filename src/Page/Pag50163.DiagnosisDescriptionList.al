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
