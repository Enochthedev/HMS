table 50152 Ward
{
    Caption = 'Ward';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Ward No"; Code[20])
        {
            Caption = 'Ward No.';
            DataClassification = CustomerContent;
        }
        field(2; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
            Editable = false;
        }
        field(3; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(4; Category; Enum "Ward Category")
        {
            Caption = 'Category';
            DataClassification = CustomerContent;
        }
        field(5; "Bed Allocation"; Integer)
        {
            Caption = 'Bed Allocation';
            DataClassification = CustomerContent;
        }
        field(6; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            DataClassification = CustomerContent;
            TableRelation = Location;
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Ward No")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        HMSSetup: Record "HMS Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        if "Ward No" <> '' then
            exit;

        HMSSetup.Get();
        HMSSetup.TestField("Ward Nos");
        "No. Series" := HMSSetup."Ward Nos";
        "Ward No" := NoSeriesMgt.GetNextNo("No. Series", WorkDate(), true);
    end;
}
