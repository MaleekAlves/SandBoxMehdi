/*------------------------------------------------------------
Author:        Tony Evans 
Company:       Arcus Global Ltd
Date:          26/07/2013
Description:   Wrapper to help work with the imported class based on the WSDL
Test Class:    
------------------------------------------------------------*/
public class ConfirmConnectorWrapper
{
    
    //test fields
    public boolean testFlag { get; set;}
    
    //Request fields  
    public String EnquiryNumber { get; set;}
    public String SubjectCode { get; set;}
    public String ServiceCode { get; set;}
	public String SiteCode { get; set;}
    public String EnquiryDescription { get; set;}
    public String EnquiryLocation { get; set;}

    //Customer fields
    public String CustomerTitle { get; set;}
	public String CustomerSurname { get; set;}
	public String CustomerForename { get; set;}
	public String CustomerPhone { get; set;}
	public String CustomerEmail { get; set;}
	public String CustomerPrimaryAddress { get; set;}
	public String CustomerSecondaryAddress { get; set;}
	public String CustomerStreetDesc { get; set;}
	public String CustomerTownName { get; set;}
	public String CustomerCountyName { get; set;}
	public String CustomerPostCode { get; set;}
    
    //Response fields
    public String ConfirmID { get; set;}
    
    public ConfirmConnectorWrapper()
    {
        testFlag = false;    
    }
    
    /** (ANA) DEPRECATE THIS FUNCTION
    public String sendConfirmSOAP(){
        ConfirmConnectorHTTP connection = new ConfirmConnectorHTTP();
        connection.Endpoint = Label.Confirm_Endpoint;
        connection.Username = Label.Confirm_Username;
        connection.DatabaseID = Label.Confirm_Tenant;
        connection.Password = Label.Confirm_Password;
        
        Map<String, String> enquiry = new Map<String, String>();
        if (this.EnquiryNumber != null){
        	enquiry.put('EnquiryNumber','1');
        }
        if (this.ServiceCode != null){
        	enquiry.put('ServiceCode',ServiceCode);
        }
        if (this.SubjectCode != null){
        	enquiry.put('SubjectCode',SubjectCode);
        }
        if (this.SiteCode != null){
        	enquiry.put('SiteCode',SiteCode);
        }
        if (this.EnquiryDescription != null){
        	enquiry.put('EnquiryDescription',EnquiryDescription);
        }
        if (this.EnquiryLocation != null){
        	enquiry.put('EnquiryLocation',EnquiryLocation);
        }
        connection.EnquiryParams = enquiry;
       
        //setup customer
        Map<String, String> customer = new Map<String, String>();
        if (this.CustomerTitle != null){
        	customer.put('CustomerTitle',CustomerTitle);
        }
		if (this.CustomerSurname != null){
        	customer.put('CustomerSurname',CustomerSurname);
        }
        if (this.CustomerForename != null){
        	customer.put('CustomerForename',CustomerForename);
        }
        if (this.CustomerPhone != null){
        	customer.put('CustomerPhone',CustomerPhone);
        }
        if (this.CustomerEmail != null){
        	customer.put('CustomerEmail',CustomerEmail );
        }
        if (this.CustomerPrimaryAddress != null){
        	customer.put('CustomerPrimaryAddress',CustomerPrimaryAddress );
        }
        if (this.CustomerPostCode != null){
        	customer.put('CustomerPostCode',CustomerPostCode );
        }
        connection.CustomerParams = customer;
        
        String responseID = '';
        responseID = connection.invoke(testFlag);
        this.ConfirmID = responseID;    
        return responseID;
    }
    */

    public ServerResponseObject sendConfirmSOAP2()
    {
        ConfirmConnectorHTTP connection = new ConfirmConnectorHTTP();
        connection.Endpoint = Label.Confirm_Endpoint;
        connection.Username = Label.Confirm_Username;
        connection.DatabaseID = Label.Confirm_Tenant;
        connection.Password = Label.Confirm_Password;
        
        Map<String, String> enquiry = new Map<String, String>();
        if (this.EnquiryNumber != null){
        	enquiry.put('EnquiryNumber','1');
        }
        if (this.ServiceCode != null){
        	enquiry.put('ServiceCode',ServiceCode);
        }
        if (this.SubjectCode != null){
        	enquiry.put('SubjectCode',SubjectCode);
        }
        if (this.SiteCode != null){
        	enquiry.put('SiteCode',SiteCode);
        }
        if (this.EnquiryDescription != null){
        	enquiry.put('EnquiryDescription',EnquiryDescription);
        }
        if (this.EnquiryLocation != null){
        	enquiry.put('EnquiryLocation',EnquiryLocation);
        }
        connection.EnquiryParams = enquiry;
       
        //setup customer
        Map<String, String> customer = new Map<String, String>();
        if (this.CustomerTitle != null){
        	customer.put('CustomerTitle',CustomerTitle);
        }
		if (this.CustomerSurname != null){
        	customer.put('CustomerSurname',CustomerSurname);
        }
        if (this.CustomerForename != null){
        	customer.put('CustomerForename',CustomerForename);
        }
        if (this.CustomerPhone != null){
        	customer.put('CustomerPhone',CustomerPhone);
        }
        if (this.CustomerEmail != null){
        	customer.put('CustomerEmail',CustomerEmail );
        }
        if (this.CustomerPrimaryAddress != null){
        	customer.put('CustomerPrimaryAddress',CustomerPrimaryAddress );
        }
        if (this.CustomerPostCode != null){
        	customer.put('CustomerPostCode',CustomerPostCode );
        }
        connection.CustomerParams = customer;
        
        ServerResponseObject srObj = connection.invoke2(testFlag);
        return srObj;
    }
    
}