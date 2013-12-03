/*------------------------------------------------------------
Author:        Tony Evans 
Company:       Arcus Global Ltd
Date:          26/07/2013
Description:   Send to Confirm
Test Class:    
------------------------------------------------------------*/
public class ConfirmConnector
{
 	
    private boolean testFlag;
    
    public ConfirmConnector (boolean testFlag)
    {
        this.testFlag = testFlag;
    }
    
    /** (ANA) DEPRECATE THIS FUNCTION 
    public String ConfirmConnectorStart (Ticket__c confirmTicket) {
        String response = 'ERROR';
        Map<String,String> targetMap = new Map<String,String>{};
        
        // if not borough ticket get the target
        if (confirmTicket.HHW_Hounslow_Borough__c != true ){
        	// $$$$ Need to change this as will error if its a borough only ticket $$$$$
       		List<Target__c> targetList = [SELECT Ticket__c, Address_Street__c FROM Target__c 
                                          WHERE Ticket__r.Id =: confirmTicket.Id];
     		//Create a map between the ticket Id and the Street address of its target
        	for(Target__c target: targetList){
				targetMap.put(target.Ticket__c,target.Address_Street__c);
        	}        
        } else {
            targetMap.put(confirmTicket.Id,'Borough of Hounslow');
        }
        
        Map<String, Confirm_Site_Codes__c> siteCodes = Confirm_Site_Codes__c.getAll(); 
        
        List<Confirm_Service_Codes__c> serviceList = [SELECT Service_Description__c, Subject_Code__c, Service_Code__c FROM Confirm_Service_Codes__c];
     	
     	//Create information on filling service codes
		Map<String,String> serviceMap = new Map<String,String>{};
        for(Confirm_Service_Codes__c service: serviceList){
			serviceMap.put(service.Service_Description__c, service.Service_Code__c+':'+service.Subject_Code__c);
        }           
             
        response = sendToConfirm(confirmTicket,serviceMap, siteCodes, targetMap);
        //response = '1234';
        return response;
    }
    */
    
    public ServerResponseObject ConfirmConnectorStart2 (Ticket__c confirmTicket) 
    {
    	ServerResponseObject servRes= new ServerResponseObject();
        //String response = 'ERROR';
        
        Map<String,String> targetMap = new Map<String,String>{};
        // if not borough ticket get the target
        if (confirmTicket.HHW_Hounslow_Borough__c != true )
        {
        	// $$$$ Need to change this as will error if its a borough only ticket $$$$$
       		List<Target__c> targetList = [SELECT Ticket__c, Address_Street__c FROM Target__c 
                                          WHERE Ticket__r.Id =: confirmTicket.Id];
     		//Create a map between the ticket Id and the Street address of its target
        	for(Target__c target: targetList)
        	{
				targetMap.put(target.Ticket__c, target.Address_Street__c);
        	}        
        }else 
        {
            targetMap.put(confirmTicket.Id,'Borough of Hounslow');
        }
        
        Map<String, Confirm_Site_Codes__c> siteCodes = Confirm_Site_Codes__c.getAll(); 
        
        List<Confirm_Service_Codes__c> serviceList = [SELECT Service_Description__c, Subject_Code__c, Service_Code__c FROM Confirm_Service_Codes__c];
     	
     	//Create information on filling service codes
		Map<String,String> serviceMap = new Map<String,String>{};
        for(Confirm_Service_Codes__c service: serviceList){
			serviceMap.put(service.Service_Description__c, service.Service_Code__c + ':' + service.Subject_Code__c);
        }           
             
        servRes = sendToConfirm2(confirmTicket,serviceMap, siteCodes, targetMap);
        return servRes;
    }    

    /** (ANA) DEPRECATE THIS FUNCTION    
    public String sendToConfirm (Ticket__c myTicket, Map<String, String> serviceMap, Map<String, Confirm_Site_Codes__c> siteCodes, Map<String,String> targetMap) {
        String response = 'ERROR  sendToConfirm';
        System.debug('******** INFO: Sending to Confirm');
        ConfirmConnectorWrapper confirmConnection = new ConfirmConnectorWrapper();
        confirmConnection.EnquiryNumber = '1';        
        System.debug('******** INFO: Confirm - Processing Service ');
        // Set everything related to the service's
        String serviceDescString = myTicket.HHW_Service__c +' - '+ myTicket.HHW_Subcategory__c;
        String serviceCodeString = serviceMap.get(serviceDescString);
        if (serviceCodeString != null){
        	confirmConnection.ServiceCode = serviceCodeString.split(':',0)[0];
        	confirmConnection.SubjectCode = serviceCodeString.split(':',0)[1];
        }
        if (myTicket.HHW_Enquiry_Description__c != null){
        	confirmConnection.EnquiryDescription = myTicket.HHW_Enquiry_Description__c ;
        }
        // Set the fields related to location
        System.debug('******** INFO: Confirm - Processing Location ');
        if (myTicket.HHW_Hounslow_Borough__c == true ){
        	confirmConnection.SiteCode = '99999999';	
        } else {
            String AddressString = targetMap.get(myTicket.Id);
            if (AddressString != null){                
        		Confirm_Site_Codes__c siteCode = siteCodes.get(AddressString);
                if (siteCode != null){              
                    String siteCodeString = siteCode.Site_Code__c.toPlainString();            	          		
                    confirmConnection.SiteCode = siteCodeString;    
            	} else {
            		confirmConnection.SiteCode = '99999999';
            	}
            } else {
            	confirmConnection.SiteCode = '99999999';
            }
        }
        if (myTicket.HHW_Location_Details__c != null){
        	confirmConnection.EnquiryLocation = myTicket.HHW_Location_Details__c;
        }
        
        createCustomerFragment(myTicket, confirmConnection);       
        // see if its a test case
        confirmConnection.testFlag = testFlag;
        //Invoke Confirm    
        response = confirmConnection.sendConfirmSOAP();
        //response = '13579';
        return response;
    }
    */

    public ServerResponseObject sendToConfirm2 (Ticket__c myTicket, Map<String, String> serviceMap, Map<String, Confirm_Site_Codes__c> siteCodes, Map<String,String> targetMap) 
    {
        ServerResponseObject response= new ServerResponseObject();
        ConfirmConnectorWrapper confirmConnection = new ConfirmConnectorWrapper();
        confirmConnection.EnquiryNumber = '1';
                
        // Set everything related to the service's
        String serviceDescString = myTicket.HHW_Service__c + ' - ' + myTicket.HHW_Subcategory__c;
        String serviceCodeString = serviceMap.get(serviceDescString);
        if (serviceCodeString != null)
        {
        	confirmConnection.ServiceCode = serviceCodeString.split(':',0)[0];
        	confirmConnection.SubjectCode = serviceCodeString.split(':',0)[1];
        }else
        {
        	response.success= false;
        	response.response= 'Please contact your administrator to provide a Service Code in the custom settings for the following service: ' + serviceDescString;
        	return response;
        }
        
        if (myTicket.HHW_Enquiry_Description__c != null)
        {
        	confirmConnection.EnquiryDescription = myTicket.HHW_Enquiry_Description__c ;
        }
        
        // Set the fields related to location
        System.debug('******** INFO: Confirm - Processing Location ');
        if (myTicket.HHW_Hounslow_Borough__c == true )
        {
        	confirmConnection.SiteCode = '99999999';	
        } else 
        {
            String AddressString = targetMap.get(myTicket.Id);
            if (AddressString != null)
            {                
        		Confirm_Site_Codes__c siteCode = siteCodes.get(AddressString);
                if (siteCode != null)
                {              
                    String siteCodeString = siteCode.Site_Code__c.toPlainString();            	          		
                    confirmConnection.SiteCode = siteCodeString;    
            	} else 
            	{
            		confirmConnection.SiteCode = '99999999';
            	}
            } else 
            {
            	confirmConnection.SiteCode = '99999999';
            }
        }

        if (myTicket.HHW_Location_Details__c != null)
        {
        	confirmConnection.EnquiryLocation = myTicket.HHW_Location_Details__c;
        }
        
        if (String.isNotBlank(myTicket.GLOBAL_Customer_Id__c))
        {
        	createCustomerFragment(myTicket, confirmConnection);
        }else
        {
			response.success= false;
			response.response= 'The ticket needs customer information in order to confirm.';
			return response;        	
        }       
        
        // see if its a test case
        confirmConnection.testFlag = testFlag;
        
        //Invoke Confirm    
        response = confirmConnection.sendConfirmSOAP2();
        return response;
    }
    
    private void createCustomerFragment (Ticket__c myTicket, ConfirmConnectorWrapper confirmConnection){
        System.debug('******** INFO: Processing Customer');
        Contact customer = new Contact();
        customer = [SELECT Id, Salutation, FirstName, LastName, HomePhone, MobilePhone, OtherPhone, Email,
                   Current_Correspondence_Address__c, Primary_Address_Postcode__c
                  FROM Contact 
                  WHERE (Id=:myTicket.GLOBAL_Customer_Id__c)][0];
                  
        confirmConnection.CustomerTitle = customer.Salutation;
        confirmConnection.CustomerForename = customer.FirstName;
       	confirmConnection.CustomerSurname = customer.LastName;
        if (customer.HomePhone != null) {
            confirmConnection.CustomerPhone = customer.HomePhone;
        } else if (customer.MobilePhone != null) {
            confirmConnection.CustomerPhone = customer.MobilePhone;
        } else if (customer.OtherPhone != null) {
            confirmConnection.CustomerPhone = customer.OtherPhone;
        }
        confirmConnection.CustomerEmail = customer.Email;
       
        //Process address
        if (customer.Current_Correspondence_Address__c != null)
        {
        	String customerAddr = customer.Current_Correspondence_Address__c;	       
            if (customerAddr.contains(','))
            {
            }
        }
        if (customer.Primary_Address_Postcode__c != null)
        {
        	confirmConnection.CustomerPostCode = customer.Primary_Address_Postcode__c;	
        }
    }
    
    public void addExternalID(String confirmTicket, String externalID)
    {
        External_ID__c externalIDObject = new External_ID__c();
        externalIDObject.Ticket__c = confirmTicket;
        externalIDObject.External_System__c = 'Confirm';
        externalIDObject.External_ID__c = externalID;
        insert externalIDObject;
    }

}