table 50151 Patient
{
    Caption = 'Patient';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Patient No"; Code[20])
        {
            Caption = 'Patient No.';
            DataClassification = CustomerContent;
        }
        field(2; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
            Editable = false;
        }
        field(3; "First Name"; Text[100])
        {
            Caption = 'First Name';
            DataClassification = CustomerContent;
        }
        field(4; "Last Name"; Text[100])
        {
            Caption = 'Last Name';
            DataClassification = CustomerContent;
        }
        field(5; "Date of Birth"; Date)
        {
            Caption = 'Date of Birth';
            DataClassification = CustomerContent;
        }
        field(6; "Blood Group"; Enum "Blood Group")
        {
            Caption = 'Blood Group';
            DataClassification = CustomerContent;
        }
        field(7; Genotype; Enum Genotype)
        {
            Caption = 'Genotype';
            DataClassification = CustomerContent;
        }
        field(8; "Email Address"; Text[100])
        {
            Caption = 'Email Address';
            DataClassification = CustomerContent;
        }
        field(9; "Phone Number"; Text[100])
        {
            Caption = 'Phone Number';
            DataClassification = CustomerContent;
        }
        field(10; "Next of Kin Name"; Text[100])
        {
            Caption = 'Next of Kin Name';
            DataClassification = CustomerContent;
        }
        field(11; "Next of Kin Contact No"; Text[100])
        {
            Caption = 'Next of Kin Contact No.';
            DataClassification = CustomerContent;
        }
        field(12; Insurance; Code[20])
        {
            Caption = 'Insurance';
            DataClassification = CustomerContent;
        }
        field(13; "Customer No"; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = CustomerContent;
            TableRelation = Customer;
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Patient No")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        HMSSetup: Record "HMS Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        if "Patient No" <> '' then
            exit;

        HMSSetup.Get();
        HMSSetup.TestField("Patient Nos");
        "No. Series" := HMSSetup."Patient Nos";
        "Patient No" := NoSeriesMgt.GetNextNo("No. Series", WorkDate(), true);
    end;
}
