pageextension 70376827 "CBR_UserSetup" extends "User Setup"
{
    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if CloseAction in [ACTION::OK, ACTION::LookupOK] then
            CBRCreateACUPermission;
    end;

    var
        RoleID: Text;
        PermissionFlag: Boolean;


    procedure CBRACUPermissionAssign(RoleName: Text)
    begin
        RoleID := RoleName;
        PermissionFlag := true;
    end;

    local procedure CBRCreateACUPermission()
    var
        UserRole: Record "Permission Set";
        Permission: Record Permission;
        AllObj: Record AllObj;
        User: Record User;
        WindowsLogin: Record User;
        WindowsAccessControl: Record "Access Control";
        UserSetupRole: Record "User Setup";
    begin
        if PermissionFlag then begin
            CurrPage.SetSelectionFilter(UserSetupRole);
            UserRole.Get(RoleID);
            if UserSetupRole.FindSet then begin
                repeat
                    WindowsLogin.SetRange("User Name", UserSetupRole."User ID");
                    if WindowsLogin.Find('-') then
                        if not WindowsAccessControl.Get(Format(WindowsLogin."User Security ID"), 'SUPER', '') then begin
                            WindowsAccessControl."User Security ID" := WindowsLogin."User Security ID";
                            WindowsAccessControl."Role ID" := UserRole."Role ID";
                            WindowsAccessControl."User Name" := WindowsLogin."User Name";
                            if not WindowsAccessControl.Insert then;
                        end;
                until UserSetupRole.Next = 0;
                Message('Roles Created Successfully For Selected Users');
            end;
        end;
    end;
}

