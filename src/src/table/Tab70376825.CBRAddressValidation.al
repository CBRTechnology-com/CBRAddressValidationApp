table 70376825 "CBR Address Validation"
{
    Caption = 'Address Validation';
    DataClassification = CustomerContent;


    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
        }
        field(2; "City"; Code[30])
        {
            Caption = 'City';
            DataClassification = CustomerContent;
        }
        field(3; "State Code"; Code[10])
        {
            Caption = 'State Code';
            DataClassification = CustomerContent;
        }
        field(4; "Postal Code"; Code[10])
        {
            Caption = 'Postal Code';
            DataClassification = CustomerContent;
        }
        field(5; "Address"; Text[100])
        {
            CaptionClass = 'Address';
            DataClassification = CustomerContent;
        }
        field(6; "Country Code"; Code[10])
        {
            Caption = 'Country Code';
            DataClassification = CustomerContent;
        }
        field(7; "Region"; Text[50])
        {
            Caption = 'Region';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
    }

    fieldgroups
    {
    }
}

