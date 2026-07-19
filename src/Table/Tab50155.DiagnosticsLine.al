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
            if (Type = const(Drug)) Item."No."
            else
            if (Type = const(Admission)) Ward."Ward No"
            else
            if (Type = const(Others)) "G/L Account"."No.";
            trigger OnValidate()
            var
                DiagnosisDescription: Record "Diagnosis Description";
                Item: Record Item;
                Ward: Record Ward;
                GLAccount: Record "G/L Account";
            begin
                Clear(Description);
                case Type of
                    Type::Drug:
                        if Item.Get("Test No") then
                            Description := Item.Description;
                    Type::Admission:
                        if Ward.Get("Test No") then
                            Description := Ward.Description;
                    Type::Others:
                        if GLAccount.Get("Test No") then
                            Description := GLAccount.Name;
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
        field(6; Closed; Boolean)
        {
            Caption = 'Closed';
            DataClassification = CustomerContent;
            Editable = false;
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
