pageextension 70376840 "CBR_ExtendsShiptoAddr" extends "Ship-to Address"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        addafter("&Address")
        {
            group("CBR Address Validation")
            {
                Caption = 'Address Validation';

                action(CBRAddressValidation)
                {
                    Caption = 'Address Validation';
                    Promoted = true;
                    ApplicationArea = All;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Image = CheckList;
                    trigger OnAction()
                    var
                        AddressValidation: Codeunit "CBR AddressValidation";
                        AddresSetup: Record "CBR Address Validation Setup";
                    begin
                        // if AddresSetup.Get() then
                        AddressValidation.ValidateAddressForShiptoaddr(Rec);
                    end;

                }
            }
        }
    }

    var
        myInt: Integer;
}