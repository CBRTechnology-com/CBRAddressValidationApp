
pageextension 70376829 "CBR_ExtendsSalesQuote" extends "Sales Quote"
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
                        Errortxt: Label ' Please Enable the Address Validation Setup';
                    begin
                        if AddresSetup.Get() then;
                        if AddresSetup."Enable for Sales" then begin
                            AddressValidation.ValidateAddressForSales(Rec);
                        end;
                    end;

                }
            }
        }
    }
}