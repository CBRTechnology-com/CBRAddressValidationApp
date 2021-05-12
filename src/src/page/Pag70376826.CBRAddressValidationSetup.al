page 70376826 "CBR_Address Validation Setup"
{
    PageType = Card;
    Caption = 'Address Validation Setup';
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "CBR address Validation Setup";
    InsertAllowed = false;
    DeleteAllowed = false;


    layout
    {
        area(Content)
        {
            group(CBRSetup)
            {
                Caption = 'Setup';
                field("Enable for Sales"; Rec."Enable for Sales")
                {
                    ToolTip = 'Enables the users to use the Address validation app for Sales documents';
                    ApplicationArea = All;
                }
                field("Enable for Purchase"; Rec."Enable for Purchase")
                {
                    ToolTip = 'Enables the users to use the Address validation app for Purchase documents';
                    ApplicationArea = All;
                }
                field("Enable for Service"; Rec."Enable for Service")
                {
                    ToolTip = 'Enables the users to use the Address validation app for Service documents';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {

        }
    }


    var
        CBRSetup: Record "CBR Address Validation Setup";

    trigger OnOpenPage()
    begin
        if not Rec.FindFirst() then
            Rec.Insert()
    end;
}