/*------------------------------------------------------------
Author:        Ana Lomibao
Company:       Arcus Global Ltd
Date:          October 2013
Description:   This class is used when an ICT ticket's status is set to closed. This will send an email to the customer notifying of the event and will create a task under the 
			   ticket to log that an email has been sent out.
Test class:    InboundTicketEmailHandler_Test.cls
------------------------------------------------------------*/
public class EmailUserOnClosedTicket implements TicketWorkFlow
{
	public static String TASK_SUBJECT= 'Emailed customer that ticket is closed';
	public static String TASK_STATUS= 'Completed';
	public static Id TASK_REC_TYPE_ID; 
	
	public static String TICKET_CLOSED_STATUS= 'Closed';
	private static String ICT_TICKET_RECORD_TYPE_ID;
	private static String ICT_EMAIL;
		
	private static String EMAIL_TEMPLATE= 'ICT_Closed_Ticket';
	
	private List<TicketToEmail> applicableTickets;
	
	public EmailUserOnClosedTicket()
	{
		// get From Address
		OrgWideEmailAddress orgEmail= [Select Id, Address From OrgWideEmailAddress Where DisplayName= 'ICT Service Desk'];
		ICT_EMAIL= orgEmail.Id;
		
		this.applicableTickets= new List<TicketToEmail>();
		List<RecordType> rts= [Select Id, Name, SobjectType From RecordType Where (SObjectType= 'Ticket__c' And Name= 'CSC - ICT Ticket') Or (SobjectType= 'Task' And Name= 'External Notifications')];
		for (RecordType rt: rts)
		{
			if (rt.SobjectType.compareTo('Ticket__c') == 0)
				ICT_TICKET_RECORD_TYPE_ID= rt.Id;
			else if (rt.SobjectType.compareTo('Task') == 0)
				TASK_REC_TYPE_ID= rt.Id;
		}		
	}
	
	/**
	 * Set all the conditions on the ticket for this workflow class to occur
	 **/ 
	public Boolean isApplicable(Ticket__c oldTicket, Ticket__c newTicket, Boolean isAnUpdate, Boolean isAnInsert)
	{
		Boolean result= false;	
		if (isAnUpdate)
		{
			// check if status field has changed and is closed
			if (newTicket.GLOBAL_Ticket_Status__c != oldTicket.GLOBAL_Ticket_Status__c 
				&& (TICKET_CLOSED_STATUS.compareTo(newTicket.GLOBAL_Ticket_Status__c) == 0) 
				&& newTicket.GLOBAL_Customer__c != null 
				&& newTicket.RecordTypeId == ICT_TICKET_RECORD_TYPE_ID
				)
			{
				result= true;
			}else
			{
				result= false;
			}
		}else if (isAnInsert == true)
		{
			// check if status field is closed
			if ((TICKET_CLOSED_STATUS.compareTo(newTicket.GLOBAL_Ticket_Status__c) == 0) 
				&& newTicket.GLOBAL_Customer__c != null
				&& newTicket.RecordTypeId == ICT_TICKET_RECORD_TYPE_ID
				)
			{
				result= true;
			}else
			{
				result= false;
			}
		}
		return result;
	}
	
	public void setApplicableTickets(Map<Id, Ticket__c> oldTickets, Map<Id, Ticket__c> newTickets, Boolean isUpdate, Boolean isInsert)
	{
    	if (isUpdate || isInsert)
    	{
	    	for (Ticket__c t: newTickets.values())
	    	{
    			if ((isUpdate && isApplicable(oldTickets.get(t.Id), t, isUpdate, isInsert)) ||
    				(isInsert && isApplicable(null, t, isUpdate, isInsert))
    				)
    			{
    				this.applicableTickets.add(new TicketToEmail(t));
    			}
	    	}
    	}
	}
	
	/**
	 * This method gets the email of the users that are associated to the tickets as contacts  
	 **/
	private void setContactEmailsInTickets()
	{
		Set<Id> contactIds= new Set<Id>();
		Set<Id> ownerIds= new Set<Id>();
		for (TicketToEmail t: this.applicableTickets)
		{
			if (t.ticket.GLOBAL_Customer__c != null && String.isNotBlank(t.ticket.GLOBAL_Customer__c))
				contactIds.add(t.ticket.GLOBAL_Customer__c);
			ownerIds.add(t.ticket.OwnerId);
		}
		
		Map<Id,Contact> contactUsers= new Map<Id,Contact>();
		if (contactIds.size() > 0)
		{
			// get contact user emails
			contactUsers.putAll([Select Id, User__c, User__r.Email From Contact Where Id In :contactIds]);
			
			for (TicketToEmail t: this.applicableTickets)
			{
				Id contactId= t.ticket.GLOBAL_Customer__c;
				if (contactId != null)
				{
					t.emailFrom= ICT_EMAIL;					
					t.emailTo= contactUsers.get(contactId).User__r.Email;
					t.emailTargetId= contactUsers.get(contactId).User__c;
				}
			}
		}		
	}
	
	/**
	 * This method contains all the actions that apply to this workflow class
	 **/
	public void applyWFToTickets()
	{
		setContactEmailsInTickets();
		
		if (applicableTickets.size() > 0)
		{
			// get email template
			EmailTemplate et= [Select Id From EmailTemplate Where DeveloperName = :EMAIL_TEMPLATE Limit 1];
			
			// email users
			List<Messaging.Singleemailmessage> emails= new List<Messaging.Singleemailmessage>();
			List<Task> tasks= new List<Task>();
			for (TicketToEmail t: applicableTickets)
			{
				if (t.emailTargetId != null) // contact record must have a user associated to it, otherwise email and task will not be created
				{				
					Messaging.Singleemailmessage e= new Messaging.Singleemailmessage();
					if (et != null)
					{
						e.setTemplateId(et.id);
						e.setWhatId(t.ticket.Id);				// ticket id
						e.setTargetObjectId(t.emailTargetId); 	// user id
						e.setOrgWideEmailAddressId(t.emailFrom);
						e.setSaveAsActivity(false);
					}
					emails.add(e);
					
					Task closedTask= new Task
					(	
						Subject= TASK_SUBJECT, 
						Status= TASK_STATUS,
						WhatId= t.ticket.Id,
						RecordTypeId= TASK_REC_TYPE_ID,
						OwnerId= UtilityQueueOwnerMapping.getUserOwnerID(t.ticket.ownerId) 
					);
					tasks.add(closedTask);
				}					
			}
			
			try
			{
				if (emails.size() > 0 && !Test.isRunningTest())
					Messaging.sendEmail(emails);
				
				// create task
				if (tasks.size() > 0) 
					insert tasks;
				
			}catch(Exception e)
			{
				throw e;
			}
		}
	}
	
	/**
	 * Wrapper class to store the email that the ticket will be sent to
	 **/
	public class TicketToEmail
	{
		public String emailTo 	{get; set;}
		public String emailFrom	{get; set;}
		public Id emailTargetId {get; set;}
		public Ticket__c ticket {get; set;}
		
		public TicketToEmail(Ticket__c t)
		{
			ticket= t;
		}
	}
}