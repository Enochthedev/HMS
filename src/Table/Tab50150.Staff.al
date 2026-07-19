table 50150 Staff
{
    Caption = 'Staff';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Staff No"; Code[20])
        {
            Caption = 'Staff No.';
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
        field(5; Type; Enum "Staff Type")
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
        }
        field(6; "Employee No"; Code[20])
        {
            Caption = 'Employee No.';
            DataClassification = CustomerContent;
            TableRelation = Employee;
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Staff No")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        HMSSetup: Record "HMS Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        if "Staff No" <> '' then
            exit;

        HMSSetup.Get();
        HMSSetup.TestField("Staff Nos");
        "No. Series" := HMSSetup."Staff Nos";
        "Staff No" := NoSeriesMgt.GetNextNo("No. Series", WorkDate(), true);
    end;
}
