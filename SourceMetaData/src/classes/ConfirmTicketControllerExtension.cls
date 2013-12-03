/*------------------------------------------------------------
Author:        Tony Evans
Company:       Arcus Global Ltd
Date:          05/07/2013
Description:   Extension class used to manage the sending of tickets to Confirm 
Test Class:    TestClass
------------------------------------------------------------*/

public with sharing class ConfirmTicketControllerExtension
{
    
	private ServerResponseObject servRes;
	public Boolean testStatus {get; set;}
	public Ticket__c ticket {get; set;}
	public String serviceDesc {get; set;}
	
	public ConfirmTicketControllerExtension(Apexpages.StandardController scon)
	{
		testStatus = false;
		servRes= new ServerResponseObject();
		if (!Test.isRunningTest())
			scon.addFields(new List<String> 
								{	'HHW_Hounslow_Borough__c', 
								 	'HHW_Service__c', 
								 	'HHW_Subcategory__c', 
								 	'GLOBAL_Customer_Name__c',
	    							'GLOBAL_Ticket_Status__c', 
	    							'HHW_Location_Details__c', 
	    							'GLOBAL_Customer_Id__c', 
	    							'HHW_Location__c', 
	    							'HHW_Enquiry_Description__c'
								}
							);
		ticket= (Ticket__c)scon.getRecord();
		
		if (ticket.HHW_Service__c != null)
			serviceDesc = ticket.HHW_Service__c;
		if (ticket.HHW_Subcategory__c != null)
		{
			if (serviceDesc != null)
				serviceDesc= serviceDesc + ' - ';
			serviceDesc= serviceDesc + ticket.HHW_Subcategory__c;
		}
	}
	
    public Pagereference sendToConfirm()
    {        
        // call confirm class - get result
        ConfirmConnector connector = new ConfirmConnector(testStatus);
        ServerResponseObject response = connector.ConfirmConnectorStart2(ticket);
        
        ApexPages.Message msg;
		if (response.success)
		{
			msg = new ApexPages.Message(ApexPages.Severity.INFO, 'Your ticket has been submittied to Hounslow Highways, the following ConfirmID has been added to the ticket= ' 
				+ response.response);
            connector.addExternalID(ticket.Id, response.response);
            ticket.GLOBAL_Ticket_Status__c = 'Closed';
            upsert ticket;			
		}else
		{
			msg = new ApexPages.Message(ApexPages.Severity.ERROR, response.response);
		}
		Apexpages.addMessage(msg);
        
		return null;
    }

}