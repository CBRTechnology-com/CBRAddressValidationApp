pageextension 70376828 "CBR_ExtendsSalesOrder" extends "Sales Order"
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
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Image = CheckList;
                    trigger OnAction()
                    var
                        AddressValidation: Codeunit "CBR AddressValidation";
                        AddresSetup: Record "CBR Address Validation Setup";
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