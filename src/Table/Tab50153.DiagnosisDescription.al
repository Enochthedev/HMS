table 50153 "Diagnosis Description"
{
    Caption = 'Diagnosis Description';
    DataClassification = CustomerContent;

    fields
    {
        field(1; Code; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; Type; Enum "Diagnosis Type")
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
        }
        field(3; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(4; "G/L Account No"; Code[20])
        {
            Caption = 'G/L Account No.';
            DataClassification = CustomerContent;
            TableRelation = "G/L Account";
        }
        field(5; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
            Editable = false;
        }
    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        HMSSetup: Record "HMS Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        if Code <> '' then
            exit;

        HMSSetup.Get();
        HMSSetup.TestField("Diagnosis Description Nos");
        "No. Series" := HMSSetup."Diagnosis Description Nos";
        Code := NoSeriesMgt.GetNextNo("No. Series", WorkDate(), true);
    end;
}
