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
@isTest
private class ManageMultipleTicketsController_Test 
{

    static testMethod void ManageMultipleTicketsController_Test() 
    {
    	User uRA= [Select Id From User Where Name= 'Root Administrator'];
    	System.runAs(uRA)
    	{
    		Test.startTest();
	       	User u= TestDataCreator.createUser();
	       	system.assertNotEquals(u, null);
	       	Contact cont= TestDataCreator.createContact(u.Id);
	       	
	   	 	// create case
			Id caseId= TestDataCreator.createCase();    	 
	       	Case ictCase= [Select Id, ContactId From Case Where Id= :caseId];
	       	ictCase.ContactId= cont.Id;
	       	ictCase.REP_Customer_Representative__c= cont.Id;
	       	update ictCase;
	       	
	    	// create an ICT tickets on the case
	        Id tId1= TestDataCreator.createTicket('CSC - ICT Ticket', ictCase.Id);
	        Id tId2= TestDataCreator.createTicket('CSC - ICT Ticket', ictCase.Id);
	        Id tId3= TestDataCreator.createTicket('CSC - ICT Ticket', ictCase.Id);
	        
	        Ticket__c ticket1= [Select Id, Name, RecordTypeId, GLOBAL_Ticket_Status__c, GLOBAL_Goal__c, GLOBAL_Customer__c, GLOBAL_Representative__c, GLOBAL_Feedback_Cutoff_Date__c 
	        	From Ticket__c Where Id= :tId1];
	        	
	        Ticket__c ticket2= [Select Id, Name, RecordTypeId, GLOBAL_Ticket_Status__c, GLOBAL_Goal__c, GLOBAL_Customer__c, GLOBAL_Representative__c, GLOBAL_Feedback_Cutoff_Date__c 
	        	From Ticket__c Where Id= :tId2];

	        Ticket__c ticket3= [Select Id, Name, RecordTypeId, GLOBAL_Ticket_Status__c, GLOBAL_Goal__c, GLOBAL_Customer__c, GLOBAL_Representative__c, GLOBAL_Feedback_Cutoff_Date__c 
	        	From Ticket__c Where Id= :tId3];	        		        	
	        
	        Apexpages.Standardcontroller scon= new Apexpages.Standardcontroller(ticket1);
	        ManageMultipleTicketsController con= new ManageMultipleTicketsController(scon);
	        
	        List<ManageMultipleTicketsController.TicketWrapper> l = con.ticketList;

	        // link all tickets
	        for (ManageMultipleTicketsController.TicketWrapper tw: l)
	        {
	        	tw.addLink= true;
	        }
	        Pagereference pref= con.link();
	        
	        // unlink all tickets
	        for (ManageMultipleTicketsController.TicketWrapper tw: l)
	        {
	        	tw.addLink= false;
	        }
	        pref= con.unlink();	        
	        
	        Test.stopTest();
    	}    	
    }
}