codeunit 70376825 "CBR AddressValidation"
{
    Permissions = tabledata 36 = rmid, tabledata 38 = rmid, tabledata 5900 = rmid;

    var
        myInt: Integer;
        LineNo: Integer;
        NodeLevel: Integer;
        BigTextimage: BigText;
        BigTextImageUPS: array[50] of BigText;
        GraficImgseq: Integer;

    local procedure AllowHttpsClient()
    var
        NAVAppSetting: Record "NAV App Setting";
        AppInfo: ModuleInfo;
    begin
        NavApp.GetCurrentModuleInfo(AppInfo);
        NAVAppSetting."App ID" := AppInfo.Id();
        NAVAppSetting."Allow HttpClient Requests" := true;
        if not NAVAppSetting.Insert() then
            NAVAppSetting.Modify();

    end;

    procedure ValidateAddressForSales(SalesHead: Record "Sales Header");
    var
        HttpClient: HttpClient;
        HttpResponce: HttpResponseMessage;
        ResponceText: Text;
        Url: Text;
        HttpContent1: HttpContent;
        I: Integer;
        Address: Record "CBR Address Validation";
        lXmlDocument: XmlDocument;
        lPersonXmlNode: XmlNode;
        lText: Text;
        lXmlNode: XMLNode;
        lXmlNodeList: XMLNodeList;
        ErrorTxt: Label 'There is no matching address found in the UPS Address book for the given address';
    begin
        AllowHttpsClient();
        Url := StrSubstNo('https://onlinetools.ups.com/ups.app/xml/XAV');
        HttpContent1.WriteFrom(GetAsFormDataforSales(SalesHead));
        HttpClient.Post(Url, HttpContent1, HttpResponce);
        HttpResponce.Content.ReadAs(ResponceText);
        Address.DeleteAll();
        XmlDocument.ReadFrom(ResponceText, lXmlDocument);
        I := 1;
        IF lXmlDocument.SelectNodes('//AddressValidationResponse/AddressKeyFormat', lXmlNodeList) then begin
            If lXmlNodeList.Count > 0 then begin
                foreach lPersonXmlNode in lXmlNodeList do begin
                    IF lPersonXmlNode.SelectSingleNode('AddressLine', lXmlNode) then begin
                        Address.Init();
                        Address."Entry No." := I;
                        Address.Address := lXmlNode.AsXmlElement.InnerText;
                        Address.Insert();
                    end;
                    IF lPersonXmlNode.SelectSingleNode('PoliticalDivision2', lXmlNode) then begin
                        Address.City := lXmlNode.AsXmlElement.InnerText;
                        Address.Modify();
                    end;
                    IF lPersonXmlNode.SelectSingleNode('PoliticalDivision1', lXmlNode) then begin
                        Address."State Code" := lXmlNode.AsXmlElement.InnerText;
                        Address.Modify();
                    end;
                    IF lPersonXmlNode.SelectSingleNode('PostcodePrimaryLow', lXmlNode) then begin
                        Address."Postal Code" := lXmlNode.AsXmlElement.InnerText;
                        Address.Modify();
                    end;
                    IF lPersonXmlNode.SelectSingleNode('CountryCode', lXmlNode) then begin
                        Address."Country Code" := lXmlNode.AsXmlElement.InnerText;
                        Address.Modify();
                    end;

                    I := I + 1;

                end;
                Commit();
                IF PAGE.RUNMODAL(PAGE::"CBR_Address Suggestion List", Address) = ACTION::LookupOK THEN BEGIN

                    SalesHead."Ship-to Address" := Address.Address;
                    SalesHead."Ship-to County" := Address."State Code";
                    SalesHead."Ship-to Post Code" := Address."Postal Code";
                    SalesHead."Ship-to City" := Address.City;
                    SalesHead.MODIFY(FALSE);
                    Message('Address has been updated successfully');
                end
            end
            else
                Error(ErrorTxt);
        end;



    end;

    procedure ValidateAddressForPurchase(PurchHeader: Record "Purchase Header");
    var
        HttpClient: HttpClient;
        HttpResponce: HttpResponseMessage;
        ResponceText: Text;
        Url: Text;
        HttpContent1: HttpContent;
        I: Integer;
        Address: Record "CBR Address Validation";
        lXmlDocument: XmlDocument;
        lPersonXmlNode: XmlNode;
        lText: Text;
        lXmlNode: XMLNode;
        lXmlNodeList: XMLNodeList;
        ErrorTxt: Label 'There is no matching address found in the UPS Address book for the given address';
    begin
        AllowHttpsClient();
        Url := StrSubstNo('https://onlinetools.ups.com/ups.app/xml/XAV');
        HttpContent1.WriteFrom(GetAsFormDataforPurch(PurchHeader));
        HttpClient.Post(Url, HttpContent1, HttpResponce);
        HttpResponce.Content.ReadAs(ResponceText);
        Address.DeleteAll();
        XmlDocument.ReadFrom(ResponceText, lXmlDocument);
        I := 1;
        IF lXmlDocument.SelectNodes('//AddressValidationResponse/AddressKeyFormat', lXmlNodeList) then begin
            If lXmlNodeList.Count > 0 then begin
                foreach lPersonXmlNode in lXmlNodeList do begin
                    IF lPersonXmlNode.SelectSingleNode('AddressLine', lXmlNode) then begin
                        Address.Init();
                        Address."Entry No." := I;
                        Address.Address := lXmlNode.AsXmlElement.InnerText;
                        Address.Insert();
                    end;
                    IF lPersonXmlNode.SelectSingleNode('PoliticalDivision2', lXmlNode) then begin
                        Address.City := lXmlNode.AsXmlElement.InnerText;
                        Address.Modify();
                    end;
                    IF lPersonXmlNode.SelectSingleNode('PoliticalDivision1', lXmlNode) then begin
                        Address."State Code" := lXmlNode.AsXmlElement.InnerText;
                        Address.Modify();
                    end;
                    IF lPersonXmlNode.SelectSingleNode('PostcodePrimaryLow', lXmlNode) then begin
                        Address."Postal Code" := lXmlNode.AsXmlElement.InnerText;
                        Address.Modify();
                    end;
                    IF lPersonXmlNode.SelectSingleNode('CountryCode', lXmlNode) then begin
                        Address."Country Code" := lXmlNode.AsXmlElement.InnerText;
                        Address.Modify();
                    end;

                    I := I + 1;

                end;
                Commit();
                IF PAGE.RUNMODAL(PAGE::"CBR_Address Suggestion List", Address) = ACTION::LookupOK THEN BEGIN
                    PurchHeader."Ship-to Address" := Address.Address;
                    PurchHeader."Ship-to County" := Address."State Code";
                    PurchHeader."Ship-to Post Code" := Address."Postal Code";
                    PurchHeader."Ship-to City" := Address.City;
                    PurchHeader.MODIFY(FALSE);
                    Message('Address has been updated successfully');
                end
            end
            else
                Error(ErrorTxt);
        end;



    end;

    procedure ValidateAddressForServ(ServHead: Record "Service Header");
    var
        HttpClient: HttpClient;
        HttpResponce: HttpResponseMessage;
        ResponceText: Text;
        Url: Text;
        HttpContent1: HttpContent;
        I: Integer;
        Address: Record "CBR Address Validation";
        lXmlDocument: XmlDocument;
        lPersonXmlNode: XmlNode;
        lText: Text;
        lXmlNode: XMLNode;
        lXmlNodeList: XMLNodeList;
        ErrorTxt: Label 'There is no matching address found in the UPS Address book for the given address';
    begin
        AllowHttpsClient();
        Url := StrSubstNo('https://onlinetools.ups.com/ups.app/xml/XAV');
        HttpContent1.WriteFrom(GetAsFormDataforServ(ServHead));
        HttpClient.Post(Url, HttpContent1, HttpResponce);
        HttpResponce.Content.ReadAs(ResponceText);
        Address.DeleteAll();
        XmlDocument.ReadFrom(ResponceText, lXmlDocument);
        I := 1;
        IF lXmlDocument.SelectNodes('//AddressValidationResponse/AddressKeyFormat', lXmlNodeList) then begin
            If lXmlNodeList.Count > 0 then begin
                foreach lPersonXmlNode in lXmlNodeList do begin
                    IF lPersonXmlNode.SelectSingleNode('AddressLine', lXmlNode) then begin
                        Address.Init();
                        Address."Entry No." := I;
                        Address.Address := lXmlNode.AsXmlElement.InnerText;
                        Address.Insert();
                    end;
                    IF lPersonXmlNode.SelectSingleNode('PoliticalDivision2', lXmlNode) then begin
                        Address.City := lXmlNode.AsXmlElement.InnerText;
                        Address.Modify();
                    end;
                    IF lPersonXmlNode.SelectSingleNode('PoliticalDivision1', lXmlNode) then begin
                        Address."State Code" := lXmlNode.AsXmlElement.InnerText;
                        Address.Modify();
                    end;
                    IF lPersonXmlNode.SelectSingleNode('PostcodePrimaryLow', lXmlNode) then begin
                        Address."Postal Code" := lXmlNode.AsXmlElement.InnerText;
                        Address.Modify();
                    end;
                    IF lPersonXmlNode.SelectSingleNode('CountryCode', lXmlNode) then begin
                        Address."Country Code" := lXmlNode.AsXmlElement.InnerText;
                        Address.Modify();
                    end;

                    I := I + 1;

                end;
                Commit();
                IF PAGE.RUNMODAL(PAGE::"CBR_Address Suggestion List", Address) = ACTION::LookupOK THEN BEGIN

                    ServHead."Ship-to Address" := Address.Address;
                    ServHead."Ship-to County" := Address."State Code";
                    ServHead."Ship-to Post Code" := Address."Postal Code";
                    ServHead."Ship-to City" := Address.City;
                    ServHead.MODIFY(FALSE);
                    Message('Address has been updated successfully');
                end
            end
            else
                Error(ErrorTxt);
        end;



    end;

    var
        Text001: Label '<?xml version="1.0" ?>';
        Text002: label '<AccessRequest xml:lang=';
        text100: Label '"';
        text200: Label '>';
        Text003: label '<AccessLicenseNumber>9D564C0C07A4E998</AccessLicenseNumber>';
        Text004: label '<UserId>kroselyne</UserId>';
        Text005: label '<Password>Winter2011</Password>';
        Text006: label '</AccessRequest>';
        Text007: label '<?xml version="1.0" ?>';
        Text008: label '<AddressValidationRequest xml:lang=';
        Text009: label '<Request>';
        Text010: label '<TransactionReference>';
        Text011: label '<CustomerContext>Your Customer Context</CustomerContext>';
        Text012: label '<RequestAction>XAV</RequestAction>';
        Text013: label '<RequestOption>1</RequestOption>';
        Text014: label '</Request>';
        Text015: label '<AddressKeyFormat>';
        text0151: Label '<AddressLine>';
        Text0152: Label '</AddressLine>';
        Text016: label ' <Region>';
        Text0161: label '</Region>';
        Text017: label '<PoliticalDivision2>';
        Text0171: label '</PoliticalDivision2>';
        Text018: label ' <PoliticalDivision1>';
        Text0181: label '</PoliticalDivision1>';
        Text019: label '<PostcodePrimaryLow>';
        Text0195: label '</PostcodePrimaryLow>';
        text0191: label '<CountryCode>';
        TExt0192: label '</CountryCode>';
        Text020: label ' </AddressKeyFormat>';
        Text021: label '</AddressValidationRequest>';
        Text023: Label '\';
        Text024: Label '</TransactionReference>';
        Ch: Text[2];

    procedure GetAsFormDataforSales(var SalesHeadr: Record "Sales Header") Data: Text

    begin
        Ch[1] := 13;
        Ch[2] := 10;
        Data := Text001 + Ch +
                Text002 + text100 + 'en-US' + text100 + text200 + ch +
                Text003 + ch +
                Text004 + ch +
                Text005 + ch +
                Text006 + ch +
                Text007 + ch +
                Text008 + text100 + 'en-US' + text100 + text200 + ch +
                Text009 + ch +
                Text010 + ch +
                Text011 + ch +
                Text024 + ch +
                Text012 + ch +
                Text013 + ch +
                Text014 + ch +
                Text015 + ch +
                Text0151 + SalesHeadr."Ship-to Address" + Text0152 + ch +
                //Text016 + text0161 + ch +
                Text017 + SalesHeadr."Ship-to City" + Text0171 + ch +
                Text018 + SalesHeadr."Ship-to County" + Text0181 + Ch +
                Text019 + SalesHeadr."Ship-to Post Code" + text0195 + ch +
                text0191 + SalesHeadr."Ship-to Country/Region Code" + text0192 + ch +
                Text020 + ch +
                Text021;
    end;

    procedure GetAsFormDataforServ(var ServHeadr: Record "Service Header") Data: Text

    begin
        Ch[1] := 13;
        Ch[2] := 10;
        Data := Text001 + Ch +
                Text002 + text100 + 'en-US' + text100 + text200 + ch +
                Text003 + ch +
                Text004 + ch +
                Text005 + ch +
                Text006 + ch +
                Text007 + ch +
                Text008 + text100 + 'en-US' + text100 + text200 + ch +
                Text009 + ch +
                Text010 + ch +
                Text011 + ch +
                Text024 + ch +
                Text012 + ch +
                Text013 + ch +
                Text014 + ch +
                Text015 + ch +
                Text0151 + ServHeadr."Ship-to Address" + Text0152 + ch +
                //Text016 + text0161 + ch +
                Text017 + ServHeadr."Ship-to City" + Text0171 + ch +
                Text018 + ServHeadr."Ship-to County" + Text0181 + Ch +
                Text019 + ServHeadr."Ship-to Post Code" + text0195 + ch +
                text0191 + ServHeadr."Ship-to Country/Region Code" + text0192 + ch +
                Text020 + ch +
                Text021;
    end;

    procedure GetAsFormDataforPurch(var PurchHeader: Record "Purchase Header") Data: Text

    begin
        Ch[1] := 13;
        Ch[2] := 10;
        Data := Text001 + Ch +
                Text002 + text100 + 'en-US' + text100 + text200 + ch +
                Text003 + ch +
                Text004 + ch +
                Text005 + ch +
                Text006 + ch +
                Text007 + ch +
                Text008 + text100 + 'en-US' + text100 + text200 + ch +
                Text009 + ch +
                Text010 + ch +
                Text011 + ch +
                Text024 + ch +
                Text012 + ch +
                Text013 + ch +
                Text014 + ch +
                Text015 + ch +
                Text0151 + PurchHeader."Buy-from Address" + Text0152 + ch +
                //Text016 + text0161 + ch +
                Text017 + PurchHeader."Buy-from City" + Text0171 + ch +
                Text018 + PurchHeader."Buy-from County" + Text0181 + Ch +
                Text019 + PurchHeader."Buy-from Post Code" + text0195 + ch +
                text0191 + PurchHeader."Buy-from Country/Region Code" + text0192 + ch +
                Text020 + ch +
                Text021;
    end;

    procedure GetAsFormDataforCust(var Cust: Record Customer) Data: Text

    begin
        Ch[1] := 13;
        Ch[2] := 10;
        Data := Text001 + Ch +
                Text002 + text100 + 'en-US' + text100 + text200 + ch +
                Text003 + ch +
                Text004 + ch +
                Text005 + ch +
                Text006 + ch +
                Text007 + ch +
                Text008 + text100 + 'en-US' + text100 + text200 + ch +
                Text009 + ch +
                Text010 + ch +
                Text011 + ch +
                Text024 + ch +
                Text012 + ch +
                Text013 + ch +
                Text014 + ch +
                Text015 + ch +
                Text0151 + Cust.Address + Text0152 + ch +
                //Text016 + text0161 + ch +
                Text017 + Cust.City + Text0171 + ch +
                Text018 + Cust.County + Text0181 + Ch +
                Text019 + Cust."Post Code" + text0195 + ch +
                text0191 + Cust."Country/Region Code" + text0192 + ch +
                Text020 + ch +
                Text021;
    end;

    procedure GetAsFormDataforVend(var Vend: Record Vendor) Data: Text

    begin
        Ch[1] := 13;
        Ch[2] := 10;
        Data := Text001 + Ch +
                Text002 + text100 + 'en-US' + text100 + text200 + ch +
                Text003 + ch +
                Text004 + ch +
                Text005 + ch +
                Text006 + ch +
                Text007 + ch +
                Text008 + text100 + 'en-US' + text100 + text200 + ch +
                Text009 + ch +
                Text010 + ch +
                Text011 + ch +
                Text024 + ch +
                Text012 + ch +
                Text013 + ch +
                Text014 + ch +
                Text015 + ch +
                Text0151 + Vend.Address + Text0152 + ch +
                //Text016 + text0161 + ch +
                Text017 + Vend.City + Text0171 + ch +
                Text018 + Vend.County + Text0181 + Ch +
                Text019 + vend."Post Code" + text0195 + ch +
                text0191 + Vend."Country/Region Code" + text0192 + ch +
                Text020 + ch +
                Text021;
    end;

    procedure ValidateAddressForCust(Cust: Record Customer);
    var
        HttpClient: HttpClient;
        HttpResponce: HttpResponseMessage;
        ResponceText: Text;
        Url: Text;
        HttpContent1: HttpContent;
        I: Integer;
        Address: Record "CBR Address Validation";
        lXmlDocument: XmlDocument;
        lPersonXmlNode: XmlNode;
        lText: Text;
        lXmlNode: XMLNode;
        lXmlNodeList: XMLNodeList;
        ErrorTxt: Label 'There is no matching address found in the UPS Address book for the given address';
    begin
        AllowHttpsClient();
        Url := StrSubstNo('https://onlinetools.ups.com/ups.app/xml/XAV');
        HttpContent1.WriteFrom(GetAsFormDataforCust(Cust));
        HttpClient.Post(Url, HttpContent1, HttpResponce);
        HttpResponce.Content.ReadAs(ResponceText);
        Address.DeleteAll();
        XmlDocument.ReadFrom(ResponceText, lXmlDocument);
        I := 1;
        IF lXmlDocument.SelectNodes('//AddressValidationResponse/AddressKeyFormat', lXmlNodeList) then begin
            If lXmlNodeList.Count > 0 then begin
                foreach lPersonXmlNode in lXmlNodeList do begin
                    IF lPersonXmlNode.SelectSingleNode('AddressLine', lXmlNode) then begin
                        Address.Init();
                        Address."Entry No." := I;
                        Address.Address := lXmlNode.AsXmlElement.InnerText;
                        Address.Insert();
                    end;
                    IF lPersonXmlNode.SelectSingleNode('PoliticalDivision2', lXmlNode) then begin
                        Address.City := lXmlNode.AsXmlElement.InnerText;
                        Address.Modify();
                    end;
                    IF lPersonXmlNode.SelectSingleNode('PoliticalDivision1', lXmlNode) then begin
                        Address."State Code" := lXmlNode.AsXmlElement.InnerText;
                        Address.Modify();
                    end;
                    IF lPersonXmlNode.SelectSingleNode('PostcodePrimaryLow', lXmlNode) then begin
                        Address."Postal Code" := lXmlNode.AsXmlElement.InnerText;
                        Address.Modify();
                    end;
                    IF lPersonXmlNode.SelectSingleNode('CountryCode', lXmlNode) then begin
                        Address."Country Code" := lXmlNode.AsXmlElement.InnerText;
                        Address.Modify();
                    end;

                    I := I + 1;

                end;
                Commit();
                IF PAGE.RUNMODAL(PAGE::"CBR_Address Suggestion List", Address) = ACTION::LookupOK THEN BEGIN

                    Cust.Address := Address.Address;
                    Cust.County := Address."State Code";
                    Cust."Post Code" := Address."Postal Code";
                    Cust.City := Address.City;
                    Cust.MODIFY(FALSE);
                    Message('Address has been updated successfully');
                end
            end
            else
                Error(ErrorTxt);
        end;



    end;

    procedure ValidateAddressForVend(Vend: Record Vendor);
    var
        HttpClient: HttpClient;
        HttpResponce: HttpResponseMessage;
        ResponceText: Text;
        Url: Text;
        HttpContent1: HttpContent;
        I: Integer;
        Address: Record "CBR Address Validation";
        lXmlDocument: XmlDocument;
        lPersonXmlNode: XmlNode;
        lText: Text;
        lXmlNode: XMLNode;
        lXmlNodeList: XMLNodeList;
        ErrorTxt: Label 'There is no matching address found in the UPS Address book for the given address';
    begin
        AllowHttpsClient();
        Url := StrSubstNo('https://onlinetools.ups.com/ups.app/xml/XAV');
        HttpContent1.WriteFrom(GetAsFormDataforVend(Vend));
        HttpClient.Post(Url, HttpContent1, HttpResponce);
        HttpResponce.Content.ReadAs(ResponceText);
        Address.DeleteAll();
        XmlDocument.ReadFrom(ResponceText, lXmlDocument);
        I := 1;
        IF lXmlDocument.SelectNodes('//AddressValidationResponse/AddressKeyFormat', lXmlNodeList) then begin
            If lXmlNodeList.Count > 0 then begin
                foreach lPersonXmlNode in lXmlNodeList do begin
                    IF lPersonXmlNode.SelectSingleNode('AddressLine', lXmlNode) then begin
                        Address.Init();
                        Address."Entry No." := I;
                        Address.Address := lXmlNode.AsXmlElement.InnerText;
                        Address.Insert();
                    end;
                    IF lPersonXmlNode.SelectSingleNode('PoliticalDivision2', lXmlNode) then begin
                        Address.City := lXmlNode.AsXmlElement.InnerText;
                        Address.Modify();
                    end;
                    IF lPersonXmlNode.SelectSingleNode('PoliticalDivision1', lXmlNode) then begin
                        Address."State Code" := lXmlNode.AsXmlElement.InnerText;
                        Address.Modify();
                    end;
                    IF lPersonXmlNode.SelectSingleNode('PostcodePrimaryLow', lXmlNode) then begin
                        Address."Postal Code" := lXmlNode.AsXmlElement.InnerText;
                        Address.Modify();
                    end;
                    IF lPersonXmlNode.SelectSingleNode('CountryCode', lXmlNode) then begin
                        Address."Country Code" := lXmlNode.AsXmlElement.InnerText;
                        Address.Modify();
                    end;

                    I := I + 1;

                end;
                Commit();
                IF PAGE.RUNMODAL(PAGE::"CBR_Address Suggestion List", Address) = ACTION::LookupOK THEN BEGIN

                    Vend.Address := Address.Address;
                    Vend.County := Address."State Code";
                    Vend."Post Code" := Address."Postal Code";
                    Vend.City := Address.City;
                    Vend.MODIFY(FALSE);
                    Message('Address has been updated successfully');
                end
            end
            else
                Error(ErrorTxt);
        end;



    end;

    procedure ValidateAddressForShiptoaddr(ShiptoAddr: Record "Ship-to Address");
    var
        HttpClient: HttpClient;
        HttpResponce: HttpResponseMessage;
        ResponceText: Text;
        Url: Text;
        HttpContent1: HttpContent;
        I: Integer;
        Address: Record "CBR Address Validation";
        lXmlDocument: XmlDocument;
        lPersonXmlNode: XmlNode;
        lText: Text;
        lXmlNode: XMLNode;
        lXmlNodeList: XMLNodeList;
        ErrorTxt: Label 'There is no matching address found in the UPS Address book for the given address';
    begin
        AllowHttpsClient();
        Url := StrSubstNo('https://onlinetools.ups.com/ups.app/xml/XAV');
        HttpContent1.WriteFrom(GetAsFormDataforShiptoaddr(ShiptoAddr));
        HttpClient.Post(Url, HttpContent1, HttpResponce);
        HttpResponce.Content.ReadAs(ResponceText);
        Address.DeleteAll();
        XmlDocument.ReadFrom(ResponceText, lXmlDocument);
        I := 1;
        IF lXmlDocument.SelectNodes('//AddressValidationResponse/AddressKeyFormat', lXmlNodeList) then begin
            If lXmlNodeList.Count > 0 then begin
                foreach lPersonXmlNode in lXmlNodeList do begin
                    IF lPersonXmlNode.SelectSingleNode('AddressLine', lXmlNode) then begin
                        Address.Init();
                        Address."Entry No." := I;
                        Address.Address := lXmlNode.AsXmlElement.InnerText;
                        Address.Insert();
                    end;
                    IF lPersonXmlNode.SelectSingleNode('PoliticalDivision2', lXmlNode) then begin
                        Address.City := lXmlNode.AsXmlElement.InnerText;
                        Address.Modify();
                    end;
                    IF lPersonXmlNode.SelectSingleNode('PoliticalDivision1', lXmlNode) then begin
                        Address."State Code" := lXmlNode.AsXmlElement.InnerText;
                        Address.Modify();
                    end;
                    IF lPersonXmlNode.SelectSingleNode('PostcodePrimaryLow', lXmlNode) then begin
                        Address."Postal Code" := lXmlNode.AsXmlElement.InnerText;
                        Address.Modify();
                    end;
                    IF lPersonXmlNode.SelectSingleNode('CountryCode', lXmlNode) then begin
                        Address."Country Code" := lXmlNode.AsXmlElement.InnerText;
                        Address.Modify();
                    end;

                    I := I + 1;

                end;
                Commit();
                IF PAGE.RUNMODAL(PAGE::"CBR_Address Suggestion List", Address) = ACTION::LookupOK THEN BEGIN

                    Shiptoaddr.Address := Address.Address;
                    Shiptoaddr.County := Address."State Code";
                    Shiptoaddr."Post Code" := Address."Postal Code";
                    Shiptoaddr.City := Address.City;
                    Shiptoaddr.MODIFY(FALSE);
                    Message('Address has been updated successfully');
                end
            end
            else
                Error(ErrorTxt);
        end;



    end;

    procedure GetAsFormDataforShiptoaddr(var Shptoaddr: Record "Ship-to Address") Data: Text

    begin
        Ch[1] := 13;
        Ch[2] := 10;
        Data := Text001 + Ch +
                Text002 + text100 + 'en-US' + text100 + text200 + ch +
                Text003 + ch +
                Text004 + ch +
                Text005 + ch +
                Text006 + ch +
                Text007 + ch +
                Text008 + text100 + 'en-US' + text100 + text200 + ch +
                Text009 + ch +
                Text010 + ch +
                Text011 + ch +
                Text024 + ch +
                Text012 + ch +
                Text013 + ch +
                Text014 + ch +
                Text015 + ch +
                Text0151 + Shptoaddr.Address + Text0152 + ch +
                //Text016 + text0161 + ch +
                Text017 + Shptoaddr.City + Text0171 + ch +
                Text018 + Shptoaddr.County + Text0181 + Ch +
                Text019 + Shptoaddr."Post Code" + text0195 + ch +
                text0191 + Shptoaddr."Country/Region Code" + text0192 + ch +
                Text020 + ch +
                Text021;
    end;
}