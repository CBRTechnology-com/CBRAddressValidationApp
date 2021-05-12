page 70376825 "CBR_Address Suggestion List"
{

    PageType = List;
    SourceTable = "CBR Address Validation";
    SourceTableView = WHERE("City" = FILTER(<> ''));
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Address; Rec."Address")
                {
                    ApplicationArea = all;
                }
                field(City; Rec."City")
                {
                    ApplicationArea = all;
                }
                field("Postal Code"; Rec."Postal Code")
                {
                    ApplicationArea = all;
                }
                field("State Code"; Rec."State Code")
                {
                    Caption = 'State Code';
                    ApplicationArea = all;
                }
                field("Country Code"; Rec."Country Code")
                {
                    ApplicationArea = all;
                }
                field(Region; Rec."Region")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

