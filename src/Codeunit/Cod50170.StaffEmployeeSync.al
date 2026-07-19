codeunit 50170 "Staff Employee Sync"
{
    procedure Run(var Staff: Record Staff)
    var
        Employee: Record Employee;
        HRSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        IsNewEmployee: Boolean;
    begin
        IsNewEmployee := Staff."Employee No" = '';
        if IsNewEmployee then begin
            HRSetup.Get();
            HRSetup.TestField("Employee Nos.");
            Employee.Init();
            Employee."No." := NoSeriesMgt.GetNextNo(HRSetup."Employee Nos.", WorkDate(), true);
        end else
            Employee.Get(Staff."Employee No");

        Employee."First Name" := Staff."First Name";
        Employee."Last Name" := Staff."Last Name";

        if IsNewEmployee then begin
            Employee.Insert(true);
            Staff."Employee No" := Employee."No.";
            Staff.Modify(true);
        end else
            Employee.Modify(true);
    end;
}
