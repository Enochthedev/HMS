table 50155 "Diagnostics Line"
{
    Caption = 'Diagnostics Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No"; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
            TableRelation = "Diagnostics Header";
        }
        field(2; "Line No"; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; Type; Enum "Diagnostics Line Type")
        {
            Caption = 'Type';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if Type <> xRec.Type then begin
                    Clear("Test No");
                    Clear(Description);
                end;
            end;
        }
        field(4; "Test No"; Code[20])
        {
            Caption = 'Test No.';
            DataClassification = CustomerContent;
            TableRelation = if (Type = const(Treatment)) "Diagnosis Description".Code where(Type = const(Treatment))
            else
            if (Type = const(Diagnosis)) "Diagnosis Description".Code where(Type = const(Diagnosis))
            else
            if (Type = const(Drug)) Drug.Code
            else
            if (Type = const(Admission)) Ward."Ward No";

            trigger OnValidate()
            var
                DiagnosisDescription: Record "Diagnosis Description";
                Drug: Record Drug;
                Ward: Record Ward;
            begin
                Clear(Description);
                case Type of
                    Type::Drug:
                        if Drug.Get("Test No") then
                            Description := Drug.Description;
                    Type::Admission:
                        if Ward.Get("Test No") then
                            Description := Ward.Description;
                    else
                        if DiagnosisDescription.Get("Test No") then
                            Description := DiagnosisDescription.Description;
                end;
            end;
        }
        field(5; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Document No", "Line No")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        DiagnosticsLine: Record "Diagnostics Line";
    begin
        if "Line No" <> 0 then
            exit;

        DiagnosticsLine.SetRange("Document No", "Document No");
        if DiagnosticsLine.FindLast() then
            "Line No" := DiagnosticsLine."Line No" + 10000
        else
            "Line No" := 10000;
    end;
}
