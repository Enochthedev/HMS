codeunit 50171 "Ward Location Sync"
{
    procedure Run(var Ward: Record Ward)
    var
        Location: Record Location;
        IsNewLocation: Boolean;
    begin
        IsNewLocation := Ward."Location Code" = '';
        if IsNewLocation then begin
            Location.Init();
            Location.Code := CopyStr(Ward."Ward No", 1, MaxStrLen(Location.Code));
        end else
            Location.Get(Ward."Location Code");

        Location.Name := Ward.Description;

        if IsNewLocation then begin
            Location.Insert(true);
            Ward."Location Code" := Location.Code;
            Ward.Modify(true);
        end else
            Location.Modify(true);
    end;
}
