/*------------------------------------------------------------
Author:        Ana Lomibao
Company:       Arcus Global Ltd
Date:          October 2013
Description:   Class that implements TicketWorkFlow, used on workflow class to update the contact references of the tickets based on the same contact references of case object
				
------------------------------------------------------------*/
public with sharing class UpdateTicketContacts implements TicketWorkFlow 
{
	public List<Ticket__c> applicableTickets;
	
	public UpdateTicketContacts()
	{
	}
	
	public void setApplicableTickets(Map<Id, Ticket__c> oldTickets, Map<Id, Ticket__c> newTickets, Boolean isUpdate, Boolean isInsert)
	{
		// WF triggered from Case object
		applicableTickets= newTickets.values();
	}
	
	public void applyWFToTickets()
	{
		for (Ticket__c t: applicableTickets)
		{
			if (t.GLOBAL_Customer__c != t.GLOBAL_Goal__r.ContactId)
				t.GLOBAL_Customer__c= t.GLOBAL_Goal__r.ContactId;
			
			if (t.GLOBAL_Representative__c != t.GLOBAL_Goal__r.REP_Customer_Representative__c)
				t.GLOBAL_Representative__c= t.GLOBAL_Goal__r.REP_Customer_Representative__c;
		}
		
		try
		{
			update applicableTickets;
		}catch (Exception e)
		{
			throw e;
		}
	}
	
}