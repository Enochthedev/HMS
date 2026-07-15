table 50154 "Diagnostics Header"
{
    Caption = 'Diagnostics Header';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No"; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(2; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
            Editable = false;
        }
        field(3; "Patient No"; Code[20])
        {
            Caption = 'Patient No.';
            DataClassification = CustomerContent;
            TableRelation = Patient;
            trigger OnValidate()
            var
                Patient: Record Patient;
            begin
                if not Patient.Get("Patient No") then
                    exit;
                "First Name" := Patient."First Name";
                "Last Name" := Patient."Last Name";
                "Blood Group" := Patient."Blood Group";
                Genotype := Patient.Genotype;
            end;
        }
        field(4; "First Name"; Text[100])
        {
            Caption = 'First Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(5; "Last Name"; Text[100])
        {
            Caption = 'Last Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(6; "Blood Group"; Enum "Blood Group")
        {
            Caption = 'Blood Group';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(7; Genotype; Enum Genotype)
        {
            Caption = 'Genotype';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(8; "Ward No"; Code[20])
        {
            Caption = 'Ward No.';
            DataClassification = CustomerContent;
            TableRelation = Ward;
        }
        field(9; Doctor; Code[20])
        {
            Caption = 'Doctor';
            DataClassification = CustomerContent;
            TableRelation = Staff."Staff No" where(Type = const(Doctor));
        }
        field(10; "Invoice No"; Code[20])
        {
            Caption = 'Invoice No.';
            DataClassification = CustomerContent;
            TableRelation = "Sales Header"."No." where("Document Type" = const(Invoice));
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Document No")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        HMSSetup: Record "HMS Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        if "Document No" <> '' then
            exit;
        HMSSetup.Get();
        HMSSetup.TestField("Diagnosis Doc Nos");
        "No. Series" := HMSSetup."Diagnosis Doc Nos";
        "Document No" := NoSeriesMgt.GetNextNo("No. Series", WorkDate(), true);
    end;
}
