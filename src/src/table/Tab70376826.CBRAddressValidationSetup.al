table 70376826 "CBR Address Validation Setup"
{
    Caption = 'Address Validation Setup';
    DataClassification = CustomerContent;


    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = CustomerContent;
        }
        field(2; "Enable for Sales"; Boolean)
        {
            Caption = 'Enable for Sales';
            DataClassification = CustomerContent;
        }
        field(3; "Enable for Purchase"; Boolean)
        {
            Caption = 'Enable for Purchase';
            DataClassification = CustomerContent;
        }
        field(4; "Enable for Service"; Boolean)
        {
            Caption = 'Enable for Service';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

    var
        CBRAV: Label 'Would you like to Add AddressValidation Roles To Users?';

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;


}