codeunit 50175 "Diagnostics Line Lookup"
{
    procedure GetDescription(Type: Enum "Diagnostics Line Type"; TestNo: Code[20]): Text[100]
    var
        DiagnosisDescription: Record "Diagnosis Description";
        Item: Record Item;
        Ward: Record Ward;
        GLAccount: Record "G/L Account";
    begin
        case Type of
            Type::Drug:
                if Item.Get(TestNo) then
                    exit(Item.Description);
            Type::Admission:
                if Ward.Get(TestNo) then
                    exit(Ward.Description);
            Type::Others:
                if GLAccount.Get(TestNo) then
                    exit(GLAccount.Name);
            else
                if DiagnosisDescription.Get(TestNo) then
                    exit(DiagnosisDescription.Description);
        end;
    end;
}
