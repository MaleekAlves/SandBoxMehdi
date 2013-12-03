/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@IsTest(seeAllData= false)
private class InboundTicketEmailHandler_Test 
{
	
    static testMethod void handleInboundEmailTest() 
    {
    	User uRA= [Select Id From User Where Name= 'Root Administrator'];
    	System.runAs(uRA)
    	{
    		Test.startTest();
	    	/** 
	    	 * Create test data
	    	 **/ 
	    	// create contact with user 
	       	User u= TestDataCreator.createUser();
	       	system.assertNotEquals(u, null);
	       	Contact con= TestDataCreator.createContact(u.Id);
	       	
	   	 	// create case
			Id caseId= TestDataCreator.createCase();    	 
	       	Case ictCase= [Select Id, ContactId From Case Where Id= :caseId];
	       	ictCase.ContactId= con.Id;
	       	ictCase.REP_Customer_Representative__c= con.Id;
	       	update ictCase;
	       	
	    	// create an ICT ticket on the case
	        Id tId= TestDataCreator.createTicket('CSC - ICT Ticket', ictCase.Id);
	        Ticket__c ticket= [Select Id, Name, RecordTypeId, GLOBAL_Ticket_Status__c, GLOBAL_Goal__c, GLOBAL_Customer__c, GLOBAL_Representative__c, GLOBAL_Feedback_Cutoff_Date__c 
	        	From Ticket__c Where Id= :tId];
	       	// assert that the customer has propagated from the case to the ticket
	       	System.assertEquals(ticket.GLOBAL_Customer__c, con.Id);
	       	
	       	// assert that ticket.GLOBAL_Customer__c is a contact associated to a user
			Map<Id,Contact> contactUsers= new Map<Id,Contact>();
			contactUsers.putAll([Select Id, User__c, User__r.Email From Contact Where Id= :ticket.GLOBAL_Customer__c]);
			System.assertNotEquals(contactUsers.get(ticket.GLOBAL_Customer__c), null);
	       	
	       	// open the ticket, this will:
	       	// - send an email to the customer
	       	// - log the event with a task
	       	ticket.GLOBAL_Ticket_Status__c= EmailUserOnOpenedTicket.TICKET_OPEN_STATUS;
	       	ContextHelper.TICKET_TRIGGER_FIRST_CALL= true;
	       	update ticket;
	       	
	       	// a task has been created
	       	List<Task> tasks;
	       	tasks= [Select Id, RecordTypeId, RecordType.Name, Subject From Task Where WhatId= :ticket.Id Order by Createddate Desc];
	       	System.assertNotEquals(0, tasks.size());
	       	System.assertEquals(tasks[0].Subject, EmailUserOnOpenedTicket.TASK_SUBJECT);
	       	delete tasks;
	       	
	        // create email and envelop objects, with subject containing a valid Ticket Name
	        Messaging.Inboundemail em= new Messaging.Inboundemail();
	        Messaging.Inboundenvelope env= new Messaging.Inboundenvelope();
	       	em.plainTextBody= 'Test body.';
	       	em.subject= 'test this ticket number ' + ticket.Name;
	       	em.fromAddress= 'test@test.com';
	       	
	       	// create email class handler to test when an email is received
	       	InboundTicketEmailHandler emHandler= new InboundTicketEmailHandler();
	       	Messaging.Inboundemailresult res= emHandler.handleInboundEmail(em, env);
	       	
	       	// the received email will be logged as a task in the system
	       	tasks= [Select Id, subject, RecordTypeId, RecordType.Name From Task Where WhatId= :ticket.Id Order by Createddate Desc];
	       	system.assertNotEquals(null, tasks);
	       	system.assertEquals(tasks[0].RecordType.Name, CreateTaskICTFeedback.RECORD_TYPE_NAME);
	       	system.assertEquals(tasks[0].subject, CreateTaskICTFeedback.EMAIL_ON_TIME_SUBJECT);
	       	delete tasks;
	       	
	        // close the ticket, this will
	        // - send email to the customer 
	        // - log the event with a task	        
			SLA__c sla= TestDataCreator.createSLA();
	        ticket.GLOBAL_Active_SLA__c= sla.Name; 	        
	        ticket.GLOBAL_Ticket_Status__c= 'Closed';
	        ticket.GLOBAL_Closed_Date__c= Date.today();
	        ContextHelper.TICKET_TRIGGER_FIRST_CALL= true;
	        update ticket;
	        ticket= [Select Id, GLOBAL_Ticket_Status__c, Name, GLOBAL_Feedback_Cutoff_Date__c, GLOBAL_Active_SLA__c, GLOBAL_SLA__c From Ticket__c Where Id= :tId];
			System.assertNotEquals(ticket.GLOBAL_Feedback_Cutoff_Date__c, null);
			tasks= [Select Id, subject, RecordTypeId, RecordType.Name From Task Where WhatId= :ticket.Id Order by Createddate Desc];
			system.assertNotEquals(tasks.size(), 0);
			system.assertEquals(tasks[0].Subject, EmailUserOnClosedTicket.TASK_SUBJECT);
			Test.stopTest();
    	}
    }
    

}