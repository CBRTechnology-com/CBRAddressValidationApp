pageextension 70376831 "CBR_ExtPurchOrder" extends "Purchase Order"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {

        addafter("F&unctions")

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
                        if AddresSetup.Get() then;
                        if AddresSetup."Enable for Purchase" then begin
                            AddressValidation.ValidateAddressForPurchase(Rec);
                        end;
                    end;
                }
            }
        }
    }
}