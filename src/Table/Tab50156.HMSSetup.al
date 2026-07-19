table 50156 "HMS Setup"
{
    Caption = 'HMS Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = CustomerContent;
        }
        field(2; "Staff Nos"; Code[20])
        {
            Caption = 'Staff Nos.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(3; "Patient Nos"; Code[20])
        {
            Caption = 'Patient Nos.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(4; "Ward Nos"; Code[20])
        {
            Caption = 'Ward Nos.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(5; "Diagnosis Doc Nos"; Code[20])
        {
            Caption = 'Diagnosis Doc Nos.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(7; "Diagnosis Description Nos"; Code[20])
        {
            Caption = 'Diagnosis Description Nos.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}
