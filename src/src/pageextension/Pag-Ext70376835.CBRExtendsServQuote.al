pageextension 70376835 "CBR_ExtendsServQuote" extends "Service Quote"
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
                        if AddresSetup."Enable for Service" then begin
                            AddressValidation.ValidateAddressForServ(Rec);
                        end;
                    end;

                }
            }
        }
    }
}