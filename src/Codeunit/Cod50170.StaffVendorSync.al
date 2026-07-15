codeunit 50170 "Staff Vendor Sync"
{
    procedure Run(var Staff: Record Staff)
    var
        Vendor: Record Vendor;
        PurchSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        IsNewVendor: Boolean;
    begin
        IsNewVendor := Staff."Vendor No" = '';
        if IsNewVendor then begin
            PurchSetup.Get();
            PurchSetup.TestField("Vendor Nos.");
            Vendor.Init();
            Vendor."No." := NoSeriesMgt.GetNextNo(PurchSetup."Vendor Nos.", WorkDate(), true);
        end else
            Vendor.Get(Staff."Vendor No");

        Vendor.Name := Staff."First Name" + ' ' + Staff."Last Name";

        if IsNewVendor then begin
            Vendor.Insert(true);
            Staff."Vendor No" := Vendor."No.";
            Staff.Modify(true);
        end else
            Vendor.Modify(true);
    end;
}
