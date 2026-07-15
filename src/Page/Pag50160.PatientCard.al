page 50160 "Patient Card"
{
    ApplicationArea = All;
    Caption = 'Patient Card';
    PageType = Card;
    SourceTable = Patient;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Patient No"; Rec."Patient No")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    trigger OnAssistEdit()
                    var
                        HMSSetup: Record "HMS Setup";
                        NoSeriesMgt: Codeunit NoSeriesManagement;
                        NoSeriesCode: Code[20];
                    begin
                        HMSSetup.Get();
                        if NoSeriesMgt.SelectSeries(HMSSetup."Patient Nos", Rec."No. Series", NoSeriesCode) then begin
                            Rec.Validate("No. Series", NoSeriesCode);
                            Rec.Validate("Patient No", NoSeriesMgt.GetNextNo(NoSeriesCode, WorkDate(), false));
                            CurrPage.Update();
                        end;
                    end;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = All;
                }
                field("Blood Group"; Rec."Blood Group")
                {
                    ApplicationArea = All;
                }
                field(Genotype; Rec.Genotype)
                {
                    ApplicationArea = All;
                }
                field("Email Address"; Rec."Email Address")
                {
                    ApplicationArea = All;
                }
                field("Phone Number"; Rec."Phone Number")
                {
                    ApplicationArea = All;
                }
                field("Next of Kin Name"; Rec."Next of Kin Name")
                {
                    ApplicationArea = All;
                }
                field("Next of Kin Contact No"; Rec."Next of Kin Contact No")
                {
                    ApplicationArea = All;
                }
                field(Insurance; Rec.Insurance)
                {
                    ApplicationArea = All;
                }
                field("Customer No"; Rec."Customer No")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(CreateUpdateCustomer)
            {
                ApplicationArea = All;
                Caption = 'Create/Update Customer';
                Image = Customer;
                trigger OnAction()
                var
                    PatientCustomerSync: Codeunit "Patient Customer Sync";
                begin
                    PatientCustomerSync.Run(Rec);
                    CurrPage.Update(false);
                    Message('Customer %1 has been created/updated.', Rec."Customer No");
                end;
            }
        }
    }
}
