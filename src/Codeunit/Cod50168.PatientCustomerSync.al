codeunit 50168 "Patient Customer Sync"
{
    procedure Run(var Patient: Record Patient)
    var
        Customer: Record Customer;
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        IsNewCustomer: Boolean;
    begin
        IsNewCustomer := Patient."Customer No" = '';
        if IsNewCustomer then begin
            SalesSetup.Get();
            SalesSetup.TestField("Customer Nos.");
            Customer.Init();
            Customer."No." := NoSeriesMgt.GetNextNo(SalesSetup."Customer Nos.", WorkDate(), true);
        end else
            Customer.Get(Patient."Customer No");

        Customer.Name := Patient."First Name" + ' ' + Patient."Last Name";
        Customer."E-Mail" := Patient."Email Address";
        Customer."Phone No." := Patient."Phone Number";

        if IsNewCustomer then begin
            Customer.Insert(true);
            Patient."Customer No" := Customer."No.";
            Patient.Modify(true);
        end else
            Customer.Modify(true);
    end;
}
